import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../configuration/app_colors.dart';
import '../repository/contact_info_repository.dart';

class ContactInfoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (CurrentSession().infoModel == null) {
      getContactUs();
    }
  }

  Future<void> getContactUs() async {
    final context = Get.context!;
    final result = await createContactInfoRepository().contactUsInfo(
      context: context,
    );

    switch (result) {
      case Failure(:final exception):
        showErrorToast(exception.message);
        break;
      case Success(:final data):
        CurrentSession().infoModel = data;
        break;
    }
  }

  void showErrorToast([String? message]) {
    Get.snackbar(
      'Failed',
      message?.isNotEmpty == true ? message! : 'Loading failed',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 10),
    );
  }
}
