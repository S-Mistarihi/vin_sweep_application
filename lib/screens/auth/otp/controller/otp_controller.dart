import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../../utils/ui/custom_dialog.dart';
import '../../auth_controller.dart';
import '../model/verify_otp_response.dart';
import '../repository/otp_repository.dart';

class OtpController extends GetxController {
  // Configuration
  static const int initialTime = 120;
  static const int otpLength = 6;

  // State
  final RxInt remainingTime = initialTime.obs;
  final RxString otpValue = ''.obs;
  final RxBool isVerifying = false.obs;

  // Controller
  final PinInputController otpTextController = PinInputController();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  // OTP Changed
  void changeOtpValue(String value) {
    otpValue.value = value;
  }

  // Clear OTP
  void clearOtpField() {
    otpTextController.clear();
    otpValue.value = '';
  }

  // Verify OTP
  Future<void> verifyOtp({
    required String email,
    required OtpType type,
    required ValueChanged<String> onSuccess,
  }) async {
    if (isVerifying.value) return;

    if (otpValue.value.length < otpLength) {
      Get.find<AuthController>().showErrorToast(
        S.of(Get.context!).oneTimePinIsRequired,
      );
      return;
    }

    isVerifying.value = true;

    try {
      final result = await createOtpRepository().verifyOtp(
        context: Get.context!,
        email: email,
        type: type,
        otpCode: otpValue.value,
      );

      switch (result) {
        case Failure(:final exception):
          //Get.find<AuthController>().showErrorToast(exception.message);
          clearOtpField();

          await CustomDialog.showErrorDialog(
            title: S.of(Get.context!).errorTitleDialog,
            description: S.of(Get.context!).errorDescriptionDialog,
          );

        case Success(:final data):
          final response = data as VerifyOtpResponse;
          await CustomDialog.showSuccessDialog(
            title: S.of(Get.context!).successTitleDialog,
            description: S.of(Get.context!).successDescriptionDialog,
          );

          onSuccess(response.result?.token ?? '');
      }
    } finally {
      isVerifying.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOtp(String email, OtpType type) async {
    if (remainingTime.value > 0) {
      return;
    }

    final result = await createOtpRepository().requestOtp(
      context: Get.context!,
      email: email,
      type: type,
    );

    switch (result) {
      case Failure(:final exception):
        Get.find<AuthController>().showErrorToast(exception.message);

      case Success():
        clearOtpField();
        startTimer();
        Get.snackbar(
          'OTP',
          S.of(Get.context!).otpResentSuccessfully,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors().successDialogColor,
          colorText: AppColors().baseColor,
        );
    }
  }

  // Timer
  void startTimer() {
    _timer?.cancel();
    remainingTime.value = initialTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpTextController.dispose();

    super.onClose();
  }
}
