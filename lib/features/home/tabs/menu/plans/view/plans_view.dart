import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/controller/plans_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/custom_card.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../utils/ui/common/custom_main_header.dart';

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> {
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
            headerMainText: 'My Plans',
            leftIcon: AppAssets().backIcon,
            size: 127,
          ),
          Positioned(
            top: 8.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Obx(() {
              return PageView.builder(
                itemCount: controller.plans.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  final plan = controller.plans[index];
                  return CustomCard(
                    plan: plan,
                    isAutoRenew: controller.isAutoRenew.value,
                    onAutoRenewChanged: controller.changeAutoRenew,
                    index: index,
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
