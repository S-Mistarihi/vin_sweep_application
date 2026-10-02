import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/repository/payment_method_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../home/tabs/menu/payment/pay-method/model/payment_method_response.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';

class ReviewConfirmationController extends GetxController {
  ReviewConfirmationController(this.plan);

  //ootion selected by user from PlansView
  final PlanModel plan;

  final methods = <PayMethod>[].obs;
  final selectedMethodId = RxnString();
  final acceptTerms = false.obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = RxnString();

  bool get canConfirm =>
      selectedMethodId.value != null &&
      acceptTerms.value &&
      !isSubmitting.value;

  @override
  void onReady() {
    super.onReady();
    loadMethods();
  }

  Future<void> loadMethods() async {
    final context = Get.context!;

    isLoading.value = true;
    errorMessage.value = null;

    final result = await createPaymentMethodRepository().getPaymentMethod(
      context: context,
    );
    switch (result) {
      case Success(:final data):
        methods.assignAll(data);
        final stillExists = methods.any(
          (m) => m.paymentMethodId == selectedMethodId.value,
        );
        if (!stillExists) {
          final fallback =
              methods.where((m) => m.resultDefault).firstOrNull ??
              methods.firstOrNull;
          selectedMethodId.value = fallback?.paymentMethodId;
        }
      case Failure(:final exception):
        errorMessage.value = exception.message;
    }

    isLoading.value = false;
  }

  void selectMethod(String id) => selectedMethodId.value = id;

  void toggleTerms(bool? value) => acceptTerms.value = value ?? false;

  Future<void> confirm() async {
    if (!canConfirm) return;

    final context = Get.context!;
    final planId = plan.id;
    if (planId == null) return;

    isSubmitting.value = true;

    final result = await createPlansRepository().subscribe(
      context: context,
      planId: planId,
      paymentMethodId: selectedMethodId.value!,
      showLoading: false,
    );

    isSubmitting.value = false;

    switch (result) {
      case Success(:final data):
        Get.back(result: data);
      case Failure(:final exception):
        _showError(exception.message);
    }
  }

  void _showError(String? message) {
    Get.snackbar(
      'Failed',
      message?.isNotEmpty == true ? message! : 'Subscription failed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 5),
    );
  }
}
