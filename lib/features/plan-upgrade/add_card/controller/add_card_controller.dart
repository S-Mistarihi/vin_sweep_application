import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/repository/card_repository.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../model/payment_intent_response.dart';

enum AddCardMode {
  ///setup-intent → add card only from (Payments Info screen)
  setup,

  ///create-payment-intent → paying subscription using new card via (Review screen)
  subscribe,
}

class _CardFlowException implements Exception {
  final String message;

  _CardFlowException(this.message);
}

class AddCardController extends GetxController {
  AddCardController(this.mode);
  late final AddCardMode mode;

  ///Subscribe mode ==> saved card after payment (go to create-payment-intent)
  ///setup mode ==> card always saved
  final RxBool saveCard = true.obs;
  final RxBool cardComplete = false.obs;
  final RxBool isLoading = false.obs;

  Future<void> addCard() async {
    if (!cardComplete.value || isLoading.value) return;

    isLoading.value = true;
    SavedCardModel? card;

    try {
      final pm = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      final brand = pm.card.brand ?? 'card';
      final last4 = pm.card.last4 ?? '****';

      switch (mode) {
        case AddCardMode.setup:
          await _saveWithSetupIntent(pm.id);
          card = SavedCardModel(
            id: pm.id,
            brand: brand,
            last4: last4,
            isSaved: true,
          );

        case AddCardMode.subscribe:
          //there is no payment/saving here;
          //payment take place upon [confirm] on ReviewScreen
          card = SavedCardModel(
            id: pm.id,
            brand: brand,
            last4: last4,
            isSaved: false,
            saveForFuture: saveCard.value,
          );
      }
    } on StripeException catch (e) {
      showAppSnackbar(
        'Card error',
        e.error.localizedMessage ?? e.error.message,
        isError: true,
      );
    } on _CardFlowException catch (e) {
      showAppSnackbar('Failed', e.message, isError: true);
    } catch (_) {
      showAppSnackbar('Failed', null, isError: true);
    }

    isLoading.value = false;
    if (card != null) Get.back(result: card);
  }

  Future<void> _saveWithSetupIntent(String paymentMethodId) async {
    final context = Get.context!;

    final intentResult = await createCardRepository().createSetupIntent(
      context: context,
    );
    final SetupIntentData intent;
    switch (intentResult) {
      case Failure(:final exception):
        throw _CardFlowException(exception.message);
      case Success(:final data):
        intent = data;
    }

    await Stripe.instance.confirmSetupIntent(
      paymentIntentClientSecret: intent.clientSecret,
      params: PaymentMethodParams.cardFromMethodId(
        paymentMethodData: PaymentMethodDataCardFromMethod(
          paymentMethodId: paymentMethodId,
        ),
      ),
    );

    final confirmResult = await createCardRepository().confirmSetupIntent(
      context: Get.context!,
      setupIntentId: intent.setupIntentId,
    );
    if (confirmResult case Failure(:final exception)) {
      throw _CardFlowException(exception.message);
    }
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
