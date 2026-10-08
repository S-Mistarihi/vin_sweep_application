import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomSnakbar {
  CustomSnakbar._();

  static const Duration _short = Duration(seconds: 5);
  static const Duration _long = Duration(seconds: 10);

  static void success(
    String title,
    String message, {
    Duration duration = _long,
  }) {
    _show(title, message, AppColors().successDialogColor, duration);
  }

  static void error(
    String title,
    String? message, {
    String fallback = 'Something went wrong',
    Duration duration = _long,
  }) {
    _show(
      title,
      message?.isNotEmpty == true ? message! : fallback,
      AppColors().errorDialogColor,
      duration,
    );
  }

  static void show(
    String title,
    String? message, {
    bool isError = false,
    String fallback = 'Something went wrong',
    Duration duration = _short,
  }) {
    _show(
      title,
      message?.isNotEmpty == true ? message! : fallback,
      isError ? AppColors().errorDialogColor : AppColors().successDialogColor,
      duration,
    );
  }

  static void _show(
    String title,
    String message,
    Color backgroundColor,
    Duration duration,
  ) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: duration,
    );
  }
}
