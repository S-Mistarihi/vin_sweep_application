import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plan_payment_intent_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/controller/card_selection_mixin.dart';
import 'package:vin_sweep_application/utils/ui/custom_dialog.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';
import '../../../home/tabs/menu/plans/model/user_plan_response.dart';

class ReviewConfirmationController extends GetxController
    with CardSelectionMixin {
  ReviewConfirmationController(this.plan);

  //option selected by user from PlansView
  final PlanModel plan;

  final RxBool acceptedTerms = false.obs;
  final RxBool isSubmitting = false.obs;
  String? _paidIntentId;

  @override
  void onInit() {
    super.onInit();
    loadCards();
  }

  Future<void> confirm() async {
    if (isSubmitting.value) return;

    final card = selectedCard;
    if (card == null) {
      showAppSnackbar(
        S.of(Get.context!).paymentMethod,
        S.of(Get.context!).pleaseSelectACard,
        isError: true,
      );
      return;
    }
    if (!acceptedTerms.value) {
      showAppSnackbar(
        S.of(Get.context!).terms,
        S.of(Get.context!).pleaseAcceptTheTermsAndConditions,
        isError: true,
      );
      return;
    }
    if (plan.id == null) return;

    final result = card.isSaved
        ? await _payWithSavedCard(card)
        : await _payWithNewCard(card);
    isSubmitting.value = false;

    switch (result) {
      case Failure(:final exception):
        showAppSnackbar(
          S.of(Get.context!).paymentFailed,
          exception.message,
          isError: true,
        );
      case Success(:final data):
        await CustomDialog.showSuccessDialog(
          title: S.of(Get.context!).subscriptionSuccessful,
          description:
              'You are now subscribed to ${plan.headlinePrimary ?? plan.name ?? 'the plan'}.',
        );
        Get.back(result: data);
    }
  }

  // pre-saved card
  Future<RepositoryResult<UserPlanResponse>> _payWithSavedCard(
    SavedCardModel card,
  ) {
    return createPlansRepository().subscribe(
      context: Get.context!,
      planId: plan.id!,
      paymentMethodId: card.id,
      saveCard: false,
      autoRenew: false,
      showLoading: true,
    );
  }

  // new card
  Future<RepositoryResult<UserPlanResponse>> _payWithNewCard(
    SavedCardModel card,
  ) async {
    final context = Get.context!;

    if (_paidIntentId != null) {
      return _activate(_paidIntentId!);
    }

    //1- backend creates PaymentIntent
    final intentResult = await createPlansRepository().createPaymentIntent(
      context: context,
      planId: plan.id!,
      saveCard: card.saveForFuture,
      autoRenew: false,
    );
    final PaymentIntentData intent;
    switch (intentResult) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        intent = data;
    }

    //2- stripe confirms payment
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
        return Failure(
          MappingException(S.of(Get.context!).paymentWasNotCompleted),
        );
      }
    } on StripeException catch (e) {
      return Failure(
        MappingException(
          e.error.localizedMessage ??
              e.error.message ??
              S.of(Get.context!).paymentFailed,
        ),
      );
    }

    _paidIntentId = intent.paymentIntentId;

    //3- backend activates subscription
    return _activate(intent.paymentIntentId);
  }

  Future<RepositoryResult<UserPlanResponse>> _activate(
    String paymentIntentId,
  ) async {
    final result = await createPlansRepository().confirmPayment(
      context: Get.context!,
      paymentIntentId: paymentIntentId,
      description: 'Plan subscription',
    );

    if (result is Success) _paidIntentId = null;
    return result;
  }
}
