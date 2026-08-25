import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.2.h,
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            //SizedBox(height: 5.h),
            Positioned(
              top: 53,
              right: 0,
              left: 36.w,
              child: Text(
                'Home',
                style: TextStyle(
                  color: AppColors().baseColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 26.54),
            Positioned(
              top: 113,
              right: 0,
              left: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Sara,',
                        style: TextStyle(
                          color: AppColors().baseColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Last Login: Yesterday at 11:00 PM',
                        style: TextStyle(
                          color: AppColors().baseColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets().carTotalSweep),
                          Text(
                            '120',
                            style: TextStyle(
                              color: AppColors().baseColor,
                              fontSize: 39,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Total Sweeps',
                        style: TextStyle(
                          color: AppColors().baseColor,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(top: 235, right: 0, left: 0, child: _buildCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: 95.w,
      height: 16.h,
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        boxShadow: [
          BoxShadow(
            color: AppColors().cardPlanShadow,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(),
    );
  }
}
