import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../configuration/app_colors.dart';

class CustomMainSubHeader extends StatelessWidget {
  final double headerSpace;
  final String headerMainText;
  final String headerSubText;
  final String leftIcon;

  const CustomMainSubHeader({
    super.key,
    required this.headerSpace,
    required this.headerMainText,
    required this.headerSubText,
    required this.leftIcon,
  });

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
                leftIcon,
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
              headerMainText,
              style: TextStyle(
                color: AppColors().baseColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 11),
            Text(
              headerSubText,
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
