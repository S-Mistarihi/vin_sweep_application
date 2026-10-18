import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/features/reports/model/report_pricing.dart';
import 'package:vin_sweep_application/features/reports/repository/report_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/ui/custom_dialog.dart';

import '../../coupon/controller/coupon_controller.dart';
import '../../plan-upgrade/review_confirmation/controller/card_selection_mixin.dart';
import '../model/report_payment_intent_model.dart';

class BuyReportController extends GetxController with CardSelectionMixin {
  BuyReportController({required this.vin, required this.vehicleName});

  final String vin;
  final String vehicleName;

  // ───────── Price ─────────
  final Rxn<ReportPricing> pricing = Rxn<ReportPricing>();
  final RxBool isLoadingPricing = false.obs;

  // ───────── Payment ─────────
  final RxBool isSubmitting = false.obs;
  String? _paidIntentId;

  CouponController get couponController {
    return Get.find<CouponController>();
  }

  @override
  void onInit() {
    super.onInit();
    loadPricing();
    loadCards();
  }

  // ───────── Price Getters ─────────
  bool get usesPackage => pricing.value?.usesPackage ?? false;

  double? get baseAmount => pricing.value?.amount;

  // final price after applyed coupon
  double? get totalAmount {
    if (usesPackage) return 0;
    return couponController.finalAmount ?? baseAmount;
  }

  bool get needsPayment {
    if (usesPackage) return false;
    final total = totalAmount;
    return total == null || total > 0;
  }

  String get priceLabel {
    if (isLoadingPricing.value) return '...';
    if (usesPackage) return '1 Report';
    final total = totalAmount;
    return total == null ? '—' : ReportPricing.money(total);
  }

  String get confirmLabel {
    if (!needsPayment) return 'Get Report';
    final total = totalAmount;
    return total == null
        ? 'Pay & Get Report'
        : 'Pay ${ReportPricing.money(total)}';
  }

  // ───────── Load Pricing ─────────
  Future<void> loadPricing() async {
    isLoadingPricing.value = true;
    final context = Get.context!;

    final (subRes, plansRes) = await (
    createPlansRepository().getCurrentUserPlan(context: context),
    createPlansRepository().getPlans(context: context),
    ).wait;

    UserPlanResponse? sub;
    if (subRes case Success(:final data)) sub = data;

    var plans = <PlanModel>[];
    if (plansRes case Success(:final data)) plans = data.plans ?? [];

    pricing.value = ReportPricing.from(sub: sub, plans: plans);

    isLoadingPricing.value = false;
  }

  // ───────── Confirm Purchase ─────────
  Future<void> confirm() async {
    if (isSubmitting.value || isLoadingPricing.value) return;

    final card = selectedCard;
    if (card == null) {
      showAppSnackbar('Payment method', 'Please select a card', isError: true);
      return;
    }

    isSubmitting.value = true;
    final result = await _purchase(card);
    isSubmitting.value = false;

    switch (result) {
      case Failure(:final exception):
        final extra = _paidIntentId != null
            ? '\nYour payment was received. Tap again to complete it. You will not be charged twice.'
            : '';

        showAppSnackbar(
          'Purchase failed',
          '${exception.message}$extra',
          isError: true,
        );

      case Success(:final data):
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().refreshAll();
        }

        await CustomDialog.showSuccessDialog(
          title: 'Report purchased',
          description: (data.message?.isNotEmpty ?? false)
              ? data.message!
              : 'Your vehicle report is ready.',
        );

        Get.back(result: data);
    }
  }

  // ───────── Purchase Flow ─────────
  Future<RepositoryResult<PdfReportDetails>> _purchase(
      SavedCardModel card,
      ) async {
    final context = Get.context!;

    // Payment succeeded previously,
    // but report activation failed.
    if (_paidIntentId != null) return _confirmPaid(_paidIntentId!);

    final code = couponController.couponCode;

    final save = card.saveForFuture;

    // 1) Create Payment Intent
    final intentResult = await createReportRepository().createPdfPaymentIntent(
      context: context,
      vin: vin,
      paymentMethodId: card.id,
      savePaymentMethod: save,
      discountCouponCode: code,
    );

    final ReportPaymentIntent intent;
    switch (intentResult) {
      case Failure(:final exception):
        return Failure(exception);

      case Success(:final data):
        intent = data;
    }

    // 2) No payment required
    // Package / balance / full coupon discount
    if (!intent.requiresPayment) {
      return createReportRepository().generateReport(
        context: Get.context!,
        vin: vin,
        paymentMethodId: card.id,
        savePaymentMethod: save,
        discountCouponCode: code,
      );
    }

    // 3) Payment is required
    if (intent.clientSecret.isEmpty) {
      return Failure(MappingException('Invalid payment intent'));
    }

    try {
      final pi = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: intent.clientSecret,
        data: PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
            paymentMethodId: card.id,
          ),
        ),
      );

      if (pi.status != PaymentIntentsStatus.Succeeded) {
        return Failure(MappingException('Payment was not completed'));
      }
    } on StripeException catch (e) {
      return Failure(
        MappingException(
          e.error.localizedMessage ?? e.error.message ?? 'Payment failed',
        ),
      );
    }

    _paidIntentId = intent.paymentIntentId;

    // 4) Confirm payment + generate report
    return _confirmPaid(intent.paymentIntentId);
  }

  // ───────── Confirm Paid Payment ─────────
  Future<RepositoryResult<PdfReportDetails>> _confirmPaid(
      String paymentIntentId,
      ) async {
    final result = await createReportRepository().confirmPdfPayment(
      context: Get.context!,
      paymentIntentId: paymentIntentId,
      vin: vin,
    );

    if (result is Success) _paidIntentId = null;

    return result;
  }
}