import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

import '../../generated/l10n.dart';

class CustomAuthHeader extends StatelessWidget {
  final bool isLogin;
  final double headerSpace;

  const CustomAuthHeader({
    super.key,
    required this.isLogin,
    required this.headerSpace,
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: headerSpace,
            ),

            Text(
              isLogin
                  ? S.of(context).loginHeaderMainText
                  : S.of(context).registerHeaderMainText,
              style: TextStyle(
                color: AppColors().baseColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 11),

            Text(
              isLogin
                  ? S.of(context).loginHeaderSubText
                  : S.of(context).registerHeaderSubText,
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
