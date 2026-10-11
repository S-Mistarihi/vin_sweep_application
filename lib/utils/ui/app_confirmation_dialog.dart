import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/custom_dual_button.dart';

class AppConfirmationDialog {
  static void show({
    required String title,
    required String desc,
    required String cancelText,
    required String okText,
    required void Function()? onCancel,
    required void Function()? onConfirm,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors().baseColor,
        elevation: 4,
        shadowColor: AppColors().cardPlanShadow,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors().firstHeaderShadowColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors().firstHeaderShadowColor,
              ),
            ),
            SizedBox(height: 12),
            CustomDualButton(
              cancelText: cancelText,
              confirmText: okText,
              onCancel: onCancel,
              onConfirm: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
