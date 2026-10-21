import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/about/controller/about_us_controller.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_copyright.dart';
import 'package:vin_sweep_application/utils/ui/custom_loading_indicator.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../../../utils/ui/custom_button.dart';
import '../../contact_us/controller/contact_info_controller.dart';
import '../../contact_us/view/contact_us_view.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});

  final AboutUsController controller = Get.find();

  void _openContactUs() {
    Get.put(ContactInfoController());
    Get.to(() => ContactUsView(), transition: Transition.rightToLeft);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: S.of(context).aboutUs,
            headerSubText: S.of(context).learnMoreAboutVinsweep,
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
              child: Obx(() {
                final text = controller.aboutText.value;

                if (text == null && controller.isLoading.value) {
                  return CustomLoadingIndicator(isLoadMore: true);
                }

                if (text == null) {
                  return _buildError(context);
                }

                return RefreshIndicator(
                  onRefresh: controller.loadAboutUs,
                  child: _buildContent(context),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final paragraphs = controller.paragraphs;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 3.h),
          _buildBadge(context),
          const SizedBox(height: 24),
          if (paragraphs.isNotEmpty) _buildIntro(paragraphs.first),
          ...paragraphs.skip(1).map(_buildParagraph),
          SizedBox(height: 3.h),
          CustomButton(
            onPressed: _openContactUs,
            text: S.of(context).contactUs,
            backgroundColor: AppColors().buttonWithBackground,
            foregroundColor: AppColors().buttonWithBackgroundText,
            textSize: 20,
            fontWeight: FontWeight.bold,
            horizontalPadding: 100,
            verticalPadding: 12,
          ),
          SizedBox(height: 3.h),
          CustomCopyright(),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors().switcherBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(AppAssets().aboutUsIcon, width: 40),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          S.of(context).vinsweep,
          style: TextStyle(
            color: AppColors().accentColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 77,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors().cardPopularBack,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildIntro(String text) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors().generalInfoContainerBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors().generalInfoContainerBorder,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors().accentColor,
          fontSize: 18,
          height: 1.6,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: AppColors().firstHeaderShadowColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 17,
                  height: 1.65,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.errorMessage.value ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors().errorText, fontSize: 18),
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: controller.loadAboutUs,
            text: S.of(context).retryButton,
            backgroundColor: AppColors().buttonWithBackground,
            foregroundColor: AppColors().buttonWithBackgroundText,
            textSize: 20,
            fontWeight: FontWeight.bold,
            horizontalPadding: 140,
            verticalPadding: 12,
          ),
        ],
      ),
    );
  }
}
