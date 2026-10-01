import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../configuration/app_colors.dart';

class PlansController extends GetxController {
  final RxBool isAutoRenew = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<PlanModel> plans = <PlanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPlans();
  }

  Future<void> changeAutoRenew(bool value) async{
    final context = Get.context!;

    final previous = isAutoRenew.value;
    isAutoRenew.value = value;

    final result = await createPlansRepository().setAutoRenew(
      context: context,
      autoRenew: value,
    );

    switch (result) {
      case Success():
        break;
      case Failure(:final exception):
        isAutoRenew.value = previous;
        showErrorToast(exception.message);
    }
  }

  Future<void> getPlans() async {
    final context = Get.context!;

    isLoading.value = true;

    final result = await createPlansRepository().getPlans(context: context);

    switch (result) {
      case Failure(:final exception):
        showErrorToast(exception.message);
        break;
      case Success(:final data):
        plans.assignAll(data.plans ?? []);
        break;
    }
    isLoading.value = false;
  }

  void showErrorToast([String? message]) {
    Get.snackbar(
      'Failed',
      message?.isNotEmpty == true ? message! : 'Loading plans failed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 5),
    );
  }
}
