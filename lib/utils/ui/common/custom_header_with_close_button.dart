import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';

import '../../../configuration/app_colors.dart';
import '../../../generated/l10n.dart';

class CustomHeaderWithCloseButton extends StatelessWidget {
  final double headerSpace;

  const CustomHeaderWithCloseButton({super.key, required this.headerSpace});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors().firstHeaderShadowColor,
            AppColors().secondHeaderShadowColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                AppAssets().closeIcon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors().baseColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              S.of(context).otpHeaderMainText,
              style: TextStyle(
                color: AppColors().baseColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 11),
            Text(
              S.of(context).otpHeaderSubText,
              style: TextStyle(
                color: AppColors().baseColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
