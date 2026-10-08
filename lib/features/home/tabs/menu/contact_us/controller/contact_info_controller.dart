import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../utils/ui/custom_snakbar.dart';
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
    CustomSnakbar.error('Failed', message, fallback: 'Loading failed');
  }

  Future<void> openUrl(String? url, {String? unavailableMessage}) async {
    if (url == null || url.trim().isEmpty) {
      showErrorToast(
        unavailableMessage ?? 'This contact option is not available',
      );
      return;
    }

    var link = url.trim();
    if (!link.contains('://')) link = 'https://$link';

    final uri = Uri.tryParse(link);
    if (uri == null || uri.host.isEmpty) {
      showErrorToast('Invalid link');
      return;
    }

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) showErrorToast('Could not open this link');
    } catch (_) {
      showErrorToast('Could not open this link');
    }
  }

  Future<void> callUs() async {
    final phone = CurrentSession().infoModel?.result?.phoneNumber;

    if (phone == null || phone.trim().isEmpty) {
      showErrorToast('Phone number is not available');
      return;
    }

    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final withCode = cleaned.startsWith('+') ? cleaned : '+1$cleaned';
    final uri = Uri(scheme: 'tel', path: withCode);

    try {
      final opened = await launchUrl(uri);
      if (!opened) showErrorToast('Could not open phone');
    } catch (_) {
      showErrorToast('Could not open phone');
    }
  }

  Future<void> openWhatsapp() async {
    final whatsapp = CurrentSession().infoModel?.result?.whatsapp?.trim();

    if (whatsapp == null || whatsapp.isEmpty) {
      showErrorToast('Whatsapp is not available');
      return;
    }

    final isNumber = RegExp(r'^\+?[\d\s\-()]+$').hasMatch(whatsapp);
    if (isNumber) {
      final digits = whatsapp.replaceAll(RegExp(r'\D'), '');
      await openUrl('https://wa.me/$digits');
    } else {
      await openUrl(whatsapp);
    }
  }

  Future<void> sendEmail() async {
    final email = CurrentSession().infoModel?.result?.email?.trim();

    if (email == null || email.isEmpty) {
      showErrorToast('Email is not available');
      return;
    }

    final uri = Uri(scheme: 'mailto', path: email);

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) showErrorToast('Could not open email');
    } catch (_) {
      showErrorToast('Could not open email');
    }
  }

  Future<void> openWebsite() async {
    await openUrl(
      CurrentSession().infoModel?.result?.websiteUrl,
      unavailableMessage: 'Website is not available',
    );
  }

  Future<void> openInstagram() async {
    await openUrl(
      CurrentSession().infoModel?.result?.instagram,
      unavailableMessage: 'Instagram is not available',
    );
  }

  Future<void> openTikTok() async {
    await openUrl(
      CurrentSession().infoModel?.result?.tiktok,
      unavailableMessage: 'TikTok is not available',
    );
  }

  Future<void> openTwitter() async {
    await openUrl(
      CurrentSession().infoModel?.result?.twitter,
      unavailableMessage: 'Twitter is not available',
    );
  }

  Future<void> openFacebook() async {
    await openUrl(
      CurrentSession().infoModel?.result?.facebook,
      unavailableMessage: 'Facebook is not available',
    );
  }

  Future<void> openYoutube() async {
    await openUrl(
      CurrentSession().infoModel?.result?.youtube,
      unavailableMessage: 'YouTube is not available',
    );
  }
}
