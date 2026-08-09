import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/screens/intro/controller/intro_controller.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../model/intro_model.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  final IntroController controller = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    controller.fillData(context);
    return Scaffold(
      backgroundColor: AppColors().baseColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),

              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: controller.skip,
                  child: Text(
                    S.of(context).skipButton,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors().subIntroText,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 7.h),

              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return _getIntroData(model: controller.screens[index]);
                  },
                  itemCount: controller.screens.length,
                  controller: controller.controller,
                  onPageChanged: controller.onPageChanged,
                ),
              ),

              SizedBox(height: 24),

              Align(
                alignment: Alignment.topLeft,
                child: SmoothPageIndicator(
                  controller: controller.controller,
                  count: controller.screens.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 12,
                    dotHeight: 6,
                    radius: 7,
                    spacing: 9,
                    activeDotColor: AppColors().activePageIndicator,
                    dotColor: AppColors().inactivePageIndicator,
                  ),
                  onDotClicked: (index) {
                    controller.controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),

              SizedBox(height: 100),

              SizedBox(
                width: 100.w,
                child: Obx(
                  () => Row(
                    children: [
                      if (controller.page.value == 1 ||
                          controller.page.value == 2)
                        Expanded(
                          child: CustomButton(
                            onPressed: controller.previousPage,
                            text: S.of(context).backButton,
                            backgroundColor:
                                AppColors().buttonWithoutBackground,
                            foregroundColor:
                                AppColors().buttonWithoutBackgroundText,
                            textSize: 16,
                            fontWeight: FontWeight.normal,
                            horizontalPadding: 45,
                            verticalPadding: 6,
                          ),
                        ),
                      if (controller.page.value == 1 ||
                          controller.page.value == 2)
                        SizedBox(width: 20),

                      Expanded(
                        child: CustomButton(
                          onPressed: controller.nextPage,
                          text:
                              controller.page.value <
                                  controller.screens.length - 1
                              ? S.of(context).nextButton
                              : S.of(context).getStartedButton,
                          backgroundColor: AppColors().buttonWithBackground,
                          foregroundColor: AppColors().buttonWithBackgroundText,
                          textSize: 16,
                          fontWeight: FontWeight.normal,
                          horizontalPadding: 45,
                          verticalPadding: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 21),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIntroData({required IntroModel model}) {
    return Column(
      children: [
        SizedBox(height: 28),
        Transform.scale(
          scale: 2.5,
          child: Lottie.asset(model.image, fit: BoxFit.fill),
        ),
        SizedBox(height: 20.h),
        Text(
          model.title,
          style: TextStyle(
            color: AppColors().mainIntroText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          model.description,
          style: TextStyle(color: AppColors().subIntroText, fontSize: 14),
        ),
      ],
    );
  }
}
