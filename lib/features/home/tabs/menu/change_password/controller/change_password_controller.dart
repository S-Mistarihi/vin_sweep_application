import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/change_password/repository/change_password_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../configuration/cache_keys.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  RxBool isPasswordObscured = true.obs;
  RxString currentPasswordError = ''.obs;
  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void changePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  void _clearErrors() {
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  Future<void> onChangePressed() async {
    _clearErrors();
    final context = Get.context!;
    final s = S.of(context);

    if (currentPasswordController.text.isEmpty) {
      currentPasswordError.value = s.pleaseFillYourPassword;
      return;
    }
    if (newPasswordController.text.isEmpty) {
      newPasswordError.value = s.pleaseFillYourPassword;
      return;
    }
    if (newPasswordController.text.length < 6) {
      newPasswordError.value = s.passwordMustBeAtLeast6Character;
      return;
    }
    if (confirmPasswordController.text.length < 6) {
      confirmPasswordError.value = s.passwordMustBeAtLeast6Character;
      return;
    }
    if (confirmPasswordController.text != newPasswordController.text) {
      confirmPasswordError.value = s.passwordsDoNotMatch;
      return;
    }
    if (currentPasswordController.text == newPasswordController.text) {
      confirmPasswordError.value = s.newPasswordMustBeDifferent;
      return;
    }

    final result = await createChangePasswordRepository().changePassword(
      context: context,
      oldPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );

    switch (result) {
      case Failure(:final exception):
        _showError(exception);
      case Success(:final data):
        await _secureStorage.write(
          key: CacheKeys.password,
          value: newPasswordController.text,
        );
        Get.back();
    }
  }

  void _showError(RepositoryException exception) {}
}
