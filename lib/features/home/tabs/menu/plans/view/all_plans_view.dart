import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/widget/plan_list_card.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_main_header.dart';
import '../../../../../../utils/ui/shimmer_list_view.dart';
import '../../../../../plan-upgrade/review_confirmation/view/review_confirmation_view.dart';

class AllPlansView extends StatelessWidget {
  const AllPlansView({super.key});

  Future<void> _select(PlansController controller, PlanModel plan) async {
    final result = await Get.to<UserPlanResponse>(
      () => ReviewConfirmationView(plan: plan),
    );
    if (result == null) return;

    await controller.onSubscribed(result);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlansController>();

    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).allPlans,
            leftIcon: AppAssets().backIcon,
            size: 120,
          ),
          Positioned(
            top: 13.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Obx(() {
                if (controller.isLoading.value && controller.plans.isEmpty) {
                  return ShimmerListView(
                    size: 3,
                    itemHeight: 280,
                    radius: 24,
                    spacing: 20,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  );
                }

                if (controller.plans.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noPlansAvailable,
                      style: TextStyle(
                        color: AppColors().textFieldLabelColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.loadData,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    itemCount: controller.plans.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (_, i) {
                      final plan = controller.plans[i];
                      return PlanListCard(
                        plan: plan,
                        isCurrent: controller.isCurrent(plan),
                        onSelect: () => _select(controller, plan),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
