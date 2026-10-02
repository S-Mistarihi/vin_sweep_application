import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../configuration/app_colors.dart';

class PlansController extends GetxController {
  final RxBool isAutoRenew = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<PlanModel> plans = <PlanModel>[].obs;
  final Rxn<UserPlanResponse> currentSubscription = Rxn<UserPlanResponse>();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  bool get hasActivePlan =>
      currentSubscription.value != null &&
      currentSubscription.value?.status == 'ACTIVE';

  bool isCurrent(PlanModel plan) =>
      hasActivePlan && currentSubscription.value?.plan?.id == plan.id;

  int get currentIndex {
    final i = plans.indexWhere(isCurrent);
    return i < 0 ? 0 : i;
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await Future.wait([_fetchPlans(), _fetchCurrentPlan()]);
    isLoading.value = false;
  }

  Future<void> _fetchPlans() async {
    final result = await createPlansRepository().getPlans(
      context: Get.context!,
    );
    switch (result) {
      case Failure(:final exception):
        _toast('Failed', exception.message, isError: true);
      case Success(:final data):
        plans.assignAll(data.plans ?? []);
    }
  }

  Future<void> _fetchCurrentPlan() async {
    final result = await createPlansRepository().getCurrentUserPlan(
      context: Get.context!,
    );
    switch (result) {
      case Failure(:final exception):
        _toast('Failed', exception.message, isError: true);
      case Success(:final data):
        currentSubscription.value = data;
        isAutoRenew.value = data?.autoRenew ?? false;
    }
  }

  /// بعد الاشتراك نرجّع نجيب الخطة من السيرفر (مصدر الحقيقة)
  Future<void> onSubscribed(UserPlanResponse subscription) async {
    currentSubscription.value = subscription;
    isAutoRenew.value = subscription.autoRenew ?? false;
    await _fetchCurrentPlan();
  }

  Future<void> changeAutoRenew(bool value) async {
    if (!hasActivePlan) return;

    final previous = isAutoRenew.value;
    isAutoRenew.value = value;

    final result = await createPlansRepository().setAutoRenew(
      context: Get.context!,
      autoRenew: value,
    );

    switch (result) {
      case Success():
        break;
      case Failure(:final exception):
        isAutoRenew.value = previous;
        _toast('Failed', exception.message, isError: true);
    }
  }

  void _toast(String title, String? message, {bool isError = false}) {
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
