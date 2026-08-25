import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/cache_keys.dart';
import 'package:vin_sweep_application/screens/home/bottom_view.dart';

import '../../../../configuration/current_session.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../auth_controller.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  RxBool isRememberMeChecked = false.obs;
  RxBool isPasswordObscured = true.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedEmail();
  }

  Future<void> _loadSavedEmail() async {
    final email = await _secureStorage.read(key: CacheKeys.email);
    if (email != null && email.isNotEmpty) {
      emailController.text = email;
      isRememberMeChecked.value = true;
    }
  }

  void changeRememberMeChecked(bool value) {
    isRememberMeChecked.value = value;
  }

  void changePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void clearForm() async {
    if (isRememberMeChecked.value) {
      final savedEmail = await _secureStorage.read(key: CacheKeys.email);

      emailController.text = savedEmail ?? '';
    } else {
      emailController.clear();
    }
    passwordController.clear();

    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();

    _clearErrors();
  }

  void _clearErrors() {
    emailError.value = '';
    passwordError.value = '';
  }

  Future<void> onLoginPressed() async {
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
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = s.pleaseFillYourPassword;
      return;
    }

    final result = await createLoginRepository().login(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    switch (result) {
      case Failure():
        Get.find<AuthController>().showErrorToast();
      case Success(:final data):
        if (isRememberMeChecked.value) {
          await _saveCredentials();
        } else {
          await _secureStorage.delete(key: CacheKeys.email);
          await _secureStorage.delete(key: CacheKeys.password);
        }
        CurrentSession().userModel = data;
        Get.offAll(() => const BottomView());
    }
  }

  Future<void> _saveCredentials() async {
    await _secureStorage.write(
      key: CacheKeys.email,
      value: emailController.text.trim(),
    );
    await _secureStorage.write(
      key: CacheKeys.password,
      value: passwordController.text,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.onClose();
  }
}
