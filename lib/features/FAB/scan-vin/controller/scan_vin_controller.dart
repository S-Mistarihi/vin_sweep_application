import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../live-scan/view/live_scan_view.dart';
import '../../search-vehicle/view/searching_view.dart';

/// كنترولر صفحة النتيجة (حقل الـ VIN + Re-scan + Search)
class ScanVinController extends GetxController {
  ScanVinController(this.initialVin);

  final String initialVin;

  late final TextEditingController vinNumberController;
  final FocusNode vinNumberNode = FocusNode();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final RxnString errorText = RxnString();

  @override
  void onInit() {
    super.onInit();
    vinNumberController = TextEditingController(text: initialVin);
  }

  /// يفتح الكاميرا من جديد ويحدّث الحقل بالرقم الجديد
  Future<void> rescan() async {
    final String? newVin = await Get.to<String>(() => const LiveScanView());

    if (newVin != null && newVin.isNotEmpty) {
      vinNumberController.text = newVin;
      errorText.value = null;
    }
  }

  void search() {
    final String vin = vinNumberController.text.trim().toUpperCase();

    if (vin.length != 17) {
      errorText.value = S.of(Get.context!).vinMustBeExactly17Characters;
      return;
    }

    errorText.value = null;
    Get.to(() => SearchingView(vinNumber: vin));
  }

  @override
  void onClose() {
    vinNumberController.dispose();
    super.onClose();
  }
}
