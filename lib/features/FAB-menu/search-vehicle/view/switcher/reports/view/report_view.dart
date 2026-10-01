import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../configuration/app_assets.dart';
import '../../../../../../../configuration/app_colors.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [_contentWithNoReportBuy()]
    );
  }

  Widget _contentWithNoReportBuy() {
    return Column(
      children: [
        SizedBox(height: 12.h),
        SvgPicture.asset(AppAssets().noReport),
        SizedBox(height: 40),
        Text(
          'No reports yet for this vehicle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors().accentColor,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Reports include accident history, mileage verification, previous owners, and more.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: AppColors().subIntroText),
        ),
      ],
    );
  }

}
