import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/custom_card.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_main_header.dart';
import '../../../../../plan-upgrade/review_confirmation/view/review_confirmation_view.dart';

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> with TickerProviderStateMixin {
  final PlansController controller = Get.find();

  late final PageController pageController;
  late final Worker _loadingWorker;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);

    _loadingWorker = ever(controller.isLoading, (loading) {
      if (loading == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && pageController.hasClients) {
            pageController.jumpToPage(controller.currentIndex);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _loadingWorker.dispose();
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
                    isCurrentPlan: controller.isCurrent(plan),
                    isAutoRenew: controller.isAutoRenew.value,
                    onAutoRenewChanged: controller.changeAutoRenew,
                    onCancel: () {
                      // TODO: Cancel Plan
                    },
                    onUpgrade: () async {
                      // TODO: open Review & Confirmation screen and pass plan
                      final result = await Get.to<UserPlanResponse>(
                        () => ReviewConfirmationView(plan: plan),
                      );
                      if (result != null) controller.onSubscribed(result);
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
