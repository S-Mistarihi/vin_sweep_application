import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/contact_us/controller/contact_info_controller.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_main_sub_header.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});

  final ContactInfoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: S.of(context).contactUs,
            headerSubText: S
                .of(context)
                .pleaseSelectTheSuitableWayForYouToReachUs,
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
                  SizedBox(height: 2.h),
                  _buildContactCard(
                    svgImage: AppAssets().icPhone,
                    text: S.of(context).callUs,
                    onTap: () => controller.callUs(),
                  ),
                  SizedBox(height: 12),
                  _buildContactCard(
                    svgImage: AppAssets().icWhats,
                    text: S.of(context).whatsapp,
                    onTap: () => controller.openWhatsapp(),
                  ),
                  SizedBox(height: 12),
                  _buildContactCard(
                    svgImage: AppAssets().icMail,
                    text: S.of(context).email,
                    onTap: () => controller.sendEmail(),
                  ),
                  SizedBox(height: 12),
                  _buildContactCard(
                    svgImage: AppAssets().icWebsite,
                    text: S.of(context).website,
                    onTap: () => controller.openWebsite(),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => controller.openInstagram(),
                        child: SvgPicture.asset(
                          AppAssets().instagram,
                          width: 58,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.openTikTok(),
                        child: SvgPicture.asset(AppAssets().tiktok, width: 58),
                      ),
                      GestureDetector(
                        onTap: () => controller.openTwitter(),
                        child: SvgPicture.asset(AppAssets().x, width: 58),
                      ),
                      GestureDetector(
                        onTap: () => controller.openFacebook(),
                        child: SvgPicture.asset(
                          AppAssets().facebook,
                          width: 58,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.openYoutube(),
                        child: SvgPicture.asset(AppAssets().youtube, width: 58),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String svgImage,
    required String text,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors().closeIconDialogColor, width: 3),
        ),
        child: Row(
          children: [
            SvgPicture.asset(svgImage, width: 25),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(color: AppColors().accentColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
