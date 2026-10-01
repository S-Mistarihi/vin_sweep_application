import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/custom_card.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_main_header.dart';

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> with TickerProviderStateMixin {
  final PlansController controller = Get.find();

  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).myPlansTitle,
            leftIcon: AppAssets().backIcon,
            size: 127,
          ),
          Positioned(
            top: 8.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: SpinKitSquareCircle(
                    color: AppColors().buttonWithBackground,
                    size: 50.0,
                    controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200),
                    ),
                  ),
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

              return PageView.builder(
                itemCount: controller.plans.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  final plan = controller.plans[index];
                  return CustomCard(
                    plan: plan,
                    // current plan subscription
                    //isCurrentPlan: plan.id == controller.currentPlanId.value,
                    isCurrentPlan: index == 0,
                    isAutoRenew: controller.isAutoRenew.value,
                    onAutoRenewChanged: controller.changeAutoRenew,
                    onCancel: () {
                      // TODO: Cancel Plan
                    },
                    onUpgrade: () {
                      // TODO: افتح شاشة Review & Confirmation ومرر plan
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
