import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';
import 'package:vin_sweep_application/features/auth/login/model/login_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/profile/repository/profile_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/custom_snakbar.dart';

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode zipCodeFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final user = CurrentSession().getUser()?.user;

    nameController.text = user?.fullName ?? '';
    zipCodeController.text = user?.zipCode.toString() ?? '';
  }

  Future<void> onSavePressed() async {
    final context = Get.context!;

    if (nameController.text.trim().isEmpty) {
      showErrorToast(S.of(context).pleaseEnterYourName);
      return;
    }
    if (zipCodeController.text.trim().isEmpty) {
      showErrorToast(S.of(context).pleaseEnterYourZipCode);
      return;
    }
    final zipCode = int.tryParse(zipCodeController.text.trim());
    if (zipCode == null) {
      showErrorToast(S.of(context).pleaseEnterAValidZipCode);
      return;
    }

    final result = await createProfileRepository().updateUser(
      context: context,
      fullName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      zipCode: zipCode,
    );

    switch (result) {
      case Failure(:final exception):
        showErrorToast(exception.message);
      case Success(:final data):
        _updateCurrentSession(data);
        CustomSnakbar.success(
          S.of(Get.context!).success,
          S.of(Get.context!).profileUpdatedSuccessfully,
          duration: const Duration(seconds: 4),
        );
        break;
    }
  }

  void _updateCurrentSession(LoginResponse response) {
    if (response.user != null) {
      CurrentSession().userModel = response.user;
    }
  }

  void showErrorToast([String? message]) {
    CustomSnakbar.error(
      S.of(Get.context!).failed,
      message,
      fallback: S.of(Get.context!).somethingWentWrong,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    zipCodeController.dispose();

    super.onClose();
  }
}
