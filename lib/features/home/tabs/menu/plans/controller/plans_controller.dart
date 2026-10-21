import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/custom_snakbar.dart';

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

  //verify that current plan is active (not expired)
  bool get hasActivePlan =>
      currentSubscription.value != null &&
      currentSubscription.value?.status == 'ACTIVE';

  bool isCurrent(PlanModel plan) =>
      hasActivePlan && currentSubscription.value?.plan?.id == plan.id;

  //arranging current cardPlan, so we can  start pageView from it
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
        _toast(S.of(Get.context!).failed, exception.message, isError: true);
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
        _toast(S.of(Get.context!).failed, exception.message, isError: true);
      case Success(:final data):
        currentSubscription.value = data;
        isAutoRenew.value = data?.autoRenew ?? false;
    }
  }

  ///after subscribing, retrieve plan from server
  Future<void> onSubscribed(UserPlanResponse subscription) async {
    currentSubscription.value = subscription;
    isAutoRenew.value = subscription.autoRenew ?? false;

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().subscription.value = subscription;
    }

    await _fetchCurrentPlan();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadPlan();
    }
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
        _toast(S.of(Get.context!).failed, exception.message, isError: true);
    }
  }

  void _toast(String title, String? message, {bool isError = false}) {
    CustomSnakbar.show(title, message, isError: isError);
  }
}
