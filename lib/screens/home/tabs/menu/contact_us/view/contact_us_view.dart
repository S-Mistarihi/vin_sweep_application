import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../utils/ui/common/custom_main_sub_header.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: 'Contact Us',
            headerSubText:
            'Please select the suitable way for you to reach us.',
            leftIcon: AppAssets().backIcon,
          ),
          Positioned(
            top: 25.h,
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
    );
  }
}
