import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../utils/ui/common/custom_main_header.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';
import '../controller/add_cart_controller.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key, this.plan, required this.mode});

  final PlanModel? plan;
  final AddCardMode mode;

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Add Card',
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }
}
