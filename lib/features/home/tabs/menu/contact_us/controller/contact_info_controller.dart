import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> openUrl(String? url) async {
    if (url == null || url.isEmpty) {
      showErrorToast('This contact option is not available');
      return;
    }

    final uri = Uri.tryParse(url);

    if (uri == null) {
      showErrorToast('Invalid link');
      return;
    }

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showErrorToast('Could not open this link');
    }
  }

  Future<void> callUs() async {
    final phone = CurrentSession().infoModel?.result?.phoneNumber;

    if (phone == null || phone.isEmpty) {
      showErrorToast('Phone number is not available');
      return;
    }

    final uri = Uri(scheme: 'tel', path: phone);

    if (!await launchUrl(uri)) {
      showErrorToast('Could not open phone');
    }
  }

  Future<void> openWhatsapp() async {
    final whatsapp = CurrentSession().infoModel?.result?.whatsapp;

    if (whatsapp == null || whatsapp.isEmpty) {
      showErrorToast('Whatsapp is not available');
      return;
    }

    await openUrl(whatsapp);
  }

  Future<void> sendEmail() async {
    final email = CurrentSession().infoModel?.result?.email;

    if (email == null || email.isEmpty) {
      showErrorToast('Email is not available');
      return;
    }

    final uri = Uri.parse('mailto:$email');

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      showErrorToast('Could not open email');
    }
  }

  Future<void> openWebsite() async {
    final website = CurrentSession().infoModel?.result?.websiteUrl;

    await openUrl(website);
  }

  Future<void> openInstagram() async {
    await openUrl(CurrentSession().infoModel?.result?.instagram);
  }

  Future<void> openTikTok() async {
    await openUrl(CurrentSession().infoModel?.result?.tiktok);
  }

  Future<void> openTwitter() async {
    await openUrl(CurrentSession().infoModel?.result?.twitter);
  }

  Future<void> openFacebook() async {
    await openUrl(CurrentSession().infoModel?.result?.facebook);
  }

  Future<void> openYoutube() async {
    await openUrl(CurrentSession().infoModel?.result?.youtube);
  }
}
