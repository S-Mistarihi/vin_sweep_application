import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/generated/l10n.dart';

import 'custom_button.dart';

class AppConfirmationDialog {
  static void show({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String? cancelText,
    Color? titleColor,
    Color? cancelBackgroundColor,
    Color? cancelForegroundColor,
    Color? confirmBackgroundColor,
    Color? confirmForegroundColor,
  }) {
    final context = Get.context!;
    Get.dialog(
      Dialog(
        backgroundColor: AppColors().baseColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: titleColor ?? AppColors().errorDialogColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().textFieldLabelColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () => Get.back(),
                      text: cancelText ?? S.of(context).cancelButton,
                      backgroundColor:
                          cancelBackgroundColor ??
                          AppColors().buttonWithoutBackground,
                      foregroundColor:
                          cancelForegroundColor ??
                          AppColors().buttonWithoutBackgroundText,
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      horizontalPadding: 0,
                      verticalPadding: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      text: confirmText,
                      backgroundColor:
                          confirmBackgroundColor ??
                          AppColors().buttonWithBackground,
                      foregroundColor:
                          confirmForegroundColor ??
                          AppColors().buttonWithBackgroundText,
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      horizontalPadding: 0,
                      verticalPadding: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
