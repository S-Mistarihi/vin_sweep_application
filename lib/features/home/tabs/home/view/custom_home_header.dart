import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/home_plan_card.dart';
import 'package:vin_sweep_application/utils/helpers/date_time_helper.dart';

import '../../../../../configuration/app_assets.dart';
import '../../../../../configuration/app_colors.dart';
import '../../../../../configuration/current_session.dart';
import '../../../../../generated/l10n.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({
    super.key,
    required this.totalSweeps,
    required this.planCard,
  });

  final int totalSweeps;
  final Widget planCard;

  @override
  Widget build(BuildContext context) {
    final user = CurrentSession().getUser()?.user;
    final firstName = user?.fullName?.trim().split(' ').first ?? '';

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
                  S.of(context).home,
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
                          S.of(context).welcome(firstName),
                          style: TextStyle(
                            color: AppColors().baseColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          S
                              .of(context)
                              .lastLogin(
                                DateTimeHelper.formateLastLogin(
                                  user?.lastLogin,
                                ),
                              ),
                          style: TextStyle(
                            color: AppColors().baseColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 1.5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SvgPicture.asset(
                          AppAssets().carTotalSweep,
                          width: 50,
                          height: 53,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$totalSweeps',
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
                    S.of(context).totalSweeps,
                    style: TextStyle(
                      color: AppColors().baseColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(top: 235, right: 0, left: 0, child: HomePlanCard()),
          ],
        ),
      ),
    );
  }
}
