import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../configuration/app_assets.dart';
import '../../configuration/app_colors.dart';
import 'custom_button.dart';

class CustomDialog {
  CustomDialog._();

  static Future<void> showErrorDialog({
    required String title,
    required String description,
  }) async {
    debugPrint(description);
    await Get.dialog(
      barrierDismissible: true,
      Dialog(
        backgroundColor: AppColors().baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => Get.back(),
                  child: Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(9.92),
                    decoration: BoxDecoration(
                      color: AppColors().closeIconDialogColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets().closeIcon,
                      width: 12,
                      height: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9.68),
              SvgPicture.asset(
                AppAssets().errorDialog,
                width: 138,
                height: 133,
              ),
              const SizedBox(height: 33.15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().errorDialogColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().textFieldLabelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () => Get.back(),
                text: 'Done',
                backgroundColor: AppColors().errorDialogColor,
                foregroundColor: AppColors().baseColor,
                textSize: 20,
                fontWeight: FontWeight.bold,
                horizontalPadding: 132,
                verticalPadding: 12,
                borderColor: AppColors().errorDialogColor,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showSuccessDialog({
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 10),
  }) async {
    Timer? autoCloseTimer;
    final dialogFuture = Get.dialog(
      barrierDismissible: true,
      Dialog(
        backgroundColor: AppColors().baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => Get.back(),
                  child: Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(9.92),
                    decoration: BoxDecoration(
                      color: AppColors().closeIconDialogColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssets().closeIcon,
                      width: 12,
                      height: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9.68),
              LottieBuilder.asset(
                AppAssets().successDialog,
                width: 138,
                height: 133,
              ),
              const SizedBox(height: 33.15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().successDialogColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().textFieldLabelColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
    autoCloseTimer = Timer(duration, () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    });

    await dialogFuture;
    autoCloseTimer.cancel();
  }
}
