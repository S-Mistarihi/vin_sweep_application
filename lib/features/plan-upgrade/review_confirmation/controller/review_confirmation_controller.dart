import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/repository/payment_method_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plan_payment_intent_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';
import 'package:vin_sweep_application/utils/ui/custom_dialog.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';
import '../../../home/tabs/menu/plans/model/user_plan_response.dart';
import '../../add_card/controller/add_card_controller.dart';
import '../../add_card/view/add_card_view.dart';

class ReviewConfirmationController extends GetxController {
  ReviewConfirmationController(this.plan);

  //ootion selected by user from PlansView
  final PlanModel plan;

  final RxList<SavedCardModel> cards = <SavedCardModel>[].obs;
  final RxnString selectedCardId = RxnString();
  final RxBool acceptedTerms = false.obs;
  final RxBool isLoadingCards = false.obs;
  final RxBool forceRefresh = false.obs;
  final RxBool isSubmitting = false.obs;

  SavedCardModel? get selectedCard =>
      cards.firstWhereOrNull((c) => c.id == selectedCardId.value);

  @override
  void onInit() {
    super.onInit();
    loadCards();
  }

  ///API saved card from PaymentInfoScreen
  Future<void> loadCards() async {
    isLoadingCards.value = true;

    final result = await createPaymentMethodRepository().getPaymentMethod(
      context: Get.context!,
      forceRefresh: forceRefresh.value,
    );

    switch (result) {
      case Failure(:final exception):
        showAppSnackbar('Failed', exception.message, isError: true);
      case Success(:final data):
        final usable = data.where((m) => !m.expired).toList();
        cards.assignAll(usable.map((m) => m.toSavedCard()));
        final preferred =
            usable.firstWhereOrNull((m) => m.resultDefault) ??
            usable.firstOrNull;
        selectedCardId.value = preferred?.paymentMethodId;
    }

    isLoadingCards.value = false;
  }

  void selectCard(SavedCardModel card) => selectedCardId.value = card.id;

  Future<void> addCard() async {
    final card = await Get.to<SavedCardModel>(
      () => const AddCardView(mode: AddCardMode.subscribe),
    );
    if (card == null) return;
    cards.insert(0, card);
    selectedCardId.value = card.id;
  }

  Future<void> confirm() async {
    if (isSubmitting.value) return;

    final card = selectedCard;
    if (card == null) {
      showAppSnackbar('Payment method', 'Please select a card', isError: true);
      return;
    }
    if (!acceptedTerms.value) {
      showAppSnackbar(
        'Terms',
        'Please accept the terms and conditions',
        isError: true,
      );
      return;
    }
    if (plan.id == null) return;

    isSubmitting.value = true;
    final result = card.isSaved
        ? await _payWithSavedCard(card)
        : await _payWithNewCard(card);
    isSubmitting.value = false;

    switch (result) {
      case Failure(:final exception):
        showAppSnackbar('Payment failed', exception.message, isError: true);
      case Success(:final data):
        await CustomDialog.showSuccessDialog(
          title: 'Subscription successful',
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
      showLoading: false,
    );
  }

  // new card
  Future<RepositoryResult<UserPlanResponse>> _payWithNewCard(
    SavedCardModel card,
  ) async {
    final context = Get.context!;

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
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: intent.clientSecret,
        data: PaymentMethodParams.cardFromMethodId(
          paymentMethodData: PaymentMethodDataCardFromMethod(
            paymentMethodId: card.id,
          ),
        ),
      );
    } on StripeException catch (e) {
      return Failure(
        MappingException(
          e.error.localizedMessage ?? e.error.message ?? 'Payment failed',
        ),
      );
    }

    //3- backend activates subscription
    return createPlansRepository().confirmPayment(
      context: Get.context!,
      paymentIntentId: intent.paymentIntentId,
      description: 'Plan subscription',
    );
  }

  void showAppSnackbar(String title, String? message, {bool isError = false}) {
    Get.snackbar(
      title,
      message?.isNotEmpty == true ? message! : 'Something went wrong',
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError
          ? AppColors().errorDialogColor
          : AppColors().successDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 5),
    );
  }
}
