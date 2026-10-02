import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';

class ReviewConfirmationView extends StatefulWidget {
  const ReviewConfirmationView({super.key, required this.plan});
  final PlanModel plan;

  @override
  State<ReviewConfirmationView> createState() => _ReviewConfirmationViewState();
}

class _ReviewConfirmationViewState extends State<ReviewConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Review & Confirmation',
            leftIcon: AppAssets().backIcon,
            size: 65,
          ),
          Positioned(
            top: 13.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [

                ],
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
