import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';

class ScanHistoryView extends StatelessWidget {
  const ScanHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Scans History',
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

                ],
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
