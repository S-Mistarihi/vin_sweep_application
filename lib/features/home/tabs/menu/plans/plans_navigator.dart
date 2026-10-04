import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/all_plans_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/my_plans_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/plans_view.dart';

class PlansNavigator {
  static Future<void> openMyPlans() async {
    final home = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : null;

    if (home != null && home.subscription.value == null) {
      await home.loadPlan();
    }

    final variant = home?.planInfo.variant;
    final hasAdvancedPlan =
        variant == HomePlanVariant.starter ||
        variant == HomePlanVariant.business ||
        variant == HomePlanVariant.premium;

    if (hasAdvancedPlan) {
      Get.to(() => const MyPlansView(), transition: Transition.rightToLeft);
    } else {
      openPlansCarousel();
    }
  }

  static void openAllPlans() {
    _ensurePlansController();
    Get.to(() => const AllPlansView(), transition: Transition.rightToLeft);
  }

  static void openPlansCarousel() {
    _ensurePlansController();
    Get.to(() => const PlansView(), transition: Transition.rightToLeft);
  }

  static void _ensurePlansController() {
    if (Get.isRegistered<PlansController>()) {
      Get.find<PlansController>().loadData();
    } else {
      Get.put(PlansController());
    }
  }
}
