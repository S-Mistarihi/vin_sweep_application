import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/my_plans_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/plans_view.dart';

class PlansNavigator {
  static void openAllPlans() {
    if (Get.isRegistered<PlansController>()) {
      Get.find<PlansController>().loadData();
    } else {
      Get.put(PlansController());
    }
    Get.to(() => const PlansView(), transition: Transition.rightToLeft);
  }

  static void openMyPlans() {
    final home = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : null;
    final variant = home?.planInfo.variant;

    final hasPlan =
        variant != null &&
            variant != HomePlanVariant.none &&
            variant != HomePlanVariant.expired;

    if (hasPlan) {
      Get.to(() => const MyPlansView(), transition: Transition.rightToLeft);
    } else {
      openAllPlans();
    }
  }
}