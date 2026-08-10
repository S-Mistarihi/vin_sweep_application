import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

enum AuthMode { login, register }

class AuthController extends GetxController {
  final Rx<AuthMode> authMode = AuthMode.login.obs;

  bool get isLogin => authMode.value == AuthMode.login;

  bool get isRegister => authMode.value == AuthMode.register;

  void switchAuthMode(AuthMode mode) {
    if (authMode.value == mode) return;

    authMode.value = mode;
  }

  void switchToLogin() {
    switchAuthMode(AuthMode.login);
  }

  void switchToRegister() {
    switchAuthMode(AuthMode.register);
  }

  double get topPosition {
    return isLogin ? 35.h : 25.h;
  }

  double get headerSpace {
    return isLogin ? 26.h : 16.h;
  }

  void showSuccessToast(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().successDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  void showErrorToast(String message) {
    Get.snackbar(
      'Warning',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
    // Get.defaultDialog(
    //   title: 'Warning',
    //   middleText: message,
    //   textConfirm: 'OK',
    //   confirmTextColor: Colors.white,
    //   buttonColor: const Color(0xFF1D416F),
    //   onConfirm: () => Get.back(),
    // );
  }
}
