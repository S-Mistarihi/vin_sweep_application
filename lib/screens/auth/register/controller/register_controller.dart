import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/screens/auth/auth_view.dart';
import 'package:vin_sweep_application/screens/auth/otp/view/otp_view.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../../utils/ui/custom_dialog.dart';
import '../../auth_controller.dart';
import '../../otp/controller/otp_controller.dart';
import '../../otp/model/verify_otp_response.dart';
import '../../otp/repository/otp_repository.dart';
import '../repository/register_repository.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode zipCodeFocusNode = FocusNode();

  final RxString nameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString zipCodeError = ''.obs;
  RxBool isPasswordObscured = true.obs;

  void changePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void _clearErrors() {
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    zipCodeError.value = '';
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    zipCodeController.clear();

    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    zipCodeFocusNode.unfocus();

    _clearErrors();
  }

  Future<void> onRegisterPressed() async {
    _clearErrors();
    final context = Get.context!;
    final s = S.of(context);

    if (nameController.text.trim().isEmpty) {
      nameError.value = s.pleaseFillYourName;
      return;
    }
    if (nameController.text.trim().length < 2) {
      nameError.value = s.pleaseEnterCorrectName;
      return;
    }
    final parts = nameController.text.trim().split(RegExp(r'\s+'));
    if (parts.length < 4) {
      nameError.value = s.pleaseFillYourName;
      return;
    }
    if (emailController.text.trim().isEmpty) {
      emailError.value = s.pleaseFillYourEmail;
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = s.pleaseEnterValidEmail;
      return;
    }
    if (passwordController.text.isEmpty) {
      passwordError.value = s.pleaseFillYourPassword;
      return;
    }
    if (passwordController.text.trim().length < 6) {
      passwordError.value = s.passwordMustBeAtLeast6Character;
      return;
    }
    if (zipCodeController.text.trim().isEmpty) {
      zipCodeError.value = s.pleaseFillYourCountryZipcode;
      return;
    }
    if (zipCodeController.text.trim().length < 3 ||
        zipCodeController.text.trim().length > 10) {
      zipCodeError.value = s.pleaseFillCorrectZipcode;
      return;
    }

    final otpResult = await createOtpRepository().generateOtp(
      context: context,
      email: emailController.text.trim(),
      type: OtpType.emailVerification,
    );

    switch (otpResult) {
      case Failure(:final exception):
        clearForm();
        Get.find<AuthController>().showErrorToast(exception.message);

      case Success():
        if (Get.isRegistered<OtpController>()) {
          Get.delete<OtpController>();
        }
        Get.to(
          () => OtpView(
            // title: s.enterTheOtpCodeSentToYourEmailAddress,
            email: emailController.text.trim(),
            type: OtpType.emailVerification,
            onSuccess: (token) => _callRegisterApi(token),
          ),
        );
    }
  }

  Future<void> _callRegisterApi(String token) async {
    final context = Get.context!;
    final result = await createRegisterRepository().register(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text,
      zipCode: zipCodeController.text.trim(),
      name: nameController.text.trim(),
      otpToken: token,
    );

    switch (result) {
      case Failure(:final exception): //email already exist & network error
        Get.find<AuthController>().showErrorToast(exception.message);
      case Success():
        await _onRegisterSuccess();
        break;
    }
  }

  Future<void> _onRegisterSuccess() async {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    zipCodeController.clear();

    await CustomDialog.showSuccessDialog(
      title: S.of(Get.context!).successTitleDialog,
      description: S.of(Get.context!).successDescriptionDialog,
    );

    Get.offAll(() => AuthView());
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    zipCodeController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    zipCodeFocusNode.dispose();

    super.onClose();
  }
}
