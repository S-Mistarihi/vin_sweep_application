import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/screens/auth/auth_controller.dart';
import 'package:vin_sweep_application/screens/auth/auth_view.dart';
import 'package:vin_sweep_application/screens/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:vin_sweep_application/screens/auth/otp/model/verify_otp_response.dart';
import 'package:vin_sweep_application/screens/auth/otp/repository/otp_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../configuration/app_colors.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  RxString emailError = ''.obs;
  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxBool isPasswordObsecured = true.obs;

  void _clearErrors() {
    emailError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  void changePasswordVisibility() {
    isPasswordObsecured.value = !isPasswordObsecured.value;
  }

  Future<void> onSubmitEmailPressed(
    BuildContext context,
    VoidCallback onOtpSent,
  ) async {
    _clearErrors();
    final context = Get.context!;
    final s = S.of(context);

    if (emailController.text.trim().isEmpty) {
      emailError.value = s.pleaseFillYourEmail;
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = s.pleaseEnterValidEmail;
      return;
    }

    final result = await createOtpRepository().generateOtp(
      context: context,
      email: emailController.text.trim(),
      type: OtpType.passwordReset,
    );

    switch (result) {
      case Failure(:final exception):
        if (Get.isRegistered<AuthController>()) {
          Get.find<AuthController>().showErrorToast(exception.message);
        } else {
          Get.snackbar(
            'Warinig',
            exception.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors().errorDialogColor,
            colorText: AppColors().baseColor,
            margin: const EdgeInsets.all(12),
            duration: const Duration(seconds: 10),
          );
        }
      case Success():
        onOtpSent();
    }
  }

  Future<void> onResetSubmitPressed(String token) async {
    _clearErrors();
    final context = Get.context!;
    final s = S.of(context);

    if (newPasswordController.text.isEmpty) {
      newPasswordError.value = s.pleaseFillYourPassword;
      return;
    }
    if (newPasswordController.text.length < 6) {
      newPasswordError.value = s.passwordMustBeAtLeast6Character;
      return;
    }
    if (confirmPasswordController.text != newPasswordController.text) {
      confirmPasswordError.value = s.confirmPasswordDoesNotMatch;
      return;
    }

    final result = await createForgotPasswordRepository().resetPassword(
      context: context,
      email: emailController.text.trim(),
      newPassword: newPasswordController.text,
      otpToken: token,
    );

    switch (result) {
      case Failure(:final exception):
        if (Get.isRegistered<AuthController>()) {
          Get.find<AuthController>().showErrorToast(exception.message);
        } else {
          Get.snackbar(
            'Warinig',
            exception.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors().errorDialogColor,
            colorText: AppColors().baseColor,
            margin: const EdgeInsets.all(12),
            duration: const Duration(seconds: 10),
          );
        }

      case Success():
        Get.offAll(() => AuthView());
        if (Get.isRegistered<AuthController>()) {
          Get.find<AuthController>().showSuccessToast(
            s.yourPasswordResetSuccessfull,
          );
        } else {
          Get.snackbar(
            'Success',
            s.yourPasswordResetSuccessfull,
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors().successDialogColor,
            colorText: AppColors().baseColor,
            margin: const EdgeInsets.all(12),
            duration: const Duration(seconds: 10),
          );
        }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    emailFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.onClose();
  }
}
