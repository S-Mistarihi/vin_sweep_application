import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_copyright.dart';
import 'package:vin_sweep_application/utils/ui/custom_dual_button.dart';

class AppConfirmationSheet {
  static void show({
    required String message,
    required String desc,
    required void Function()? onConfirm,
    required String confirmText,
  }) {
    Get.bottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      Container(
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: AppColors().baseColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors().closeIconDialogColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppAssets().closeIcon),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: 130,
                height: 130,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors().deleteDialog,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 50,
                  color: AppColors().baseColor,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 3.5.h),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().textFieldLabelColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4.5.h),
              CustomDualButton(
                cancelText: 'Cancel',
                confirmText: confirmText,
                onCancel: () => Get.back(),
                onConfirm: onConfirm,
                cancelBackgroundColor: Colors.transparent,
                cancelForegroundColor: AppColors().textFieldLabelColor,
                confirmBackgroundColor: AppColors().deleteDialog,
                confirmForegroundColor: AppColors().baseColor,
                cancelBorderColor: AppColors().textFieldLabelColor,
                confirmBorderColor: AppColors().deleteDialog,
              ),
              SizedBox(height: 3.h),
              CustomCopyright(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
