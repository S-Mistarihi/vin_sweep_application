import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h,),
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors().logoutButton,
                ),
              ),
              SizedBox(height: 12),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors().firstHeaderShadowColor,
                ),
              ),
              SizedBox(height: 24),
              CustomDualButton(
                cancelText: cancelText,
                confirmText: okText,
                onCancel: onCancel,
                onConfirm: onConfirm,
                confirmBackgroundColor: AppColors().logoutButton,
                confirmForegroundColor: AppColors().baseColor,
                confirmBorderColor: AppColors().logoutButton,
                cancelBackgroundColor: Colors.transparent,
                cancelForegroundColor: AppColors().firstHeaderShadowColor,
                cancelBorderColor: AppColors().firstHeaderShadowColor,
              ),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      ),
    );
  }
}
