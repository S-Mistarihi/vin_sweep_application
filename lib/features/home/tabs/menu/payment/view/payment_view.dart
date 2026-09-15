import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../utils/ui/custom_button.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Payments Info',
            leftIcon: AppAssets().backIcon,
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
                  SizedBox(height: 12.h),
                  CustomButton(
                    onPressed: () {
                      // if (_key.currentState!.validate()) {
                      //   controller.onChangePressed();
                      // }
                    },
                    text: 'Add Payment Method',
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 100,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 3.h),
                  SvgPicture.asset(
                    AppAssets().copyRightIcon,
                    width: 212,
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
