import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';

import '../../../configuration/app_colors.dart';
import '../../../generated/l10n.dart';

class CustomMainHeader extends StatelessWidget {
  final double headerSpace;
  final String headerMainText;
  final String leftIcon;

  const CustomMainHeader({
    super.key,
    required this.headerSpace,
    required this.headerMainText,
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
            Row(
              children: [
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
                SizedBox(width: 88),
                Text(
                  headerMainText,
                  style: TextStyle(
                    color: AppColors().baseColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
