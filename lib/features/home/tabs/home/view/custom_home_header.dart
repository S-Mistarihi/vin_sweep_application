import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/utils/helpers/date_time_helper.dart';

import '../../../../../configuration/app_assets.dart';
import '../../../../../configuration/app_colors.dart';
import '../../../../../configuration/current_session.dart';

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
            Column(
              children: [
                SizedBox(height: 5.h),
                Text(
                  'Home',
                  style: TextStyle(
                    color: AppColors().baseColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${CurrentSession().getUser()!.user!.fullName!.split(' ').first},',
                          style: TextStyle(
                            color: AppColors().baseColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Last Login: ${DateTimeHelper.formateLastLogin(CurrentSession().getUser()?.user?.lastLogin)}',
                          style: TextStyle(
                            color: AppColors().baseColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset(
                      AppAssets().carTotalSweep,
                      width: 50,
                      height: 53,
                    ),
                    SizedBox(width: 8),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Total Sweeps',
                    style: TextStyle(
                      color: AppColors().baseColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
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
