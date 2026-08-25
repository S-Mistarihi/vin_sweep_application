import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/custom_home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomHomeHeader(),
          SizedBox(height: 13.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Latest Scans',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().accentColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(child: SvgPicture.asset(AppAssets().emptyHomeScreen)),
          SizedBox(height: 2.h),
          Text(
            'No Scans Yet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors().mainColorWithNoScans,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'The list is currently empty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors().textFieldLabelColor,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
