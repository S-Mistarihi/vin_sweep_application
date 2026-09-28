import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/generated/l10n.dart';

import '../../search-vin/view/search_vin_view.dart';

class EnterVinController extends GetxController {
  final TextEditingController vinNumberController = TextEditingController();
  final FocusNode vinNumberNode = FocusNode();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final context = Get.context!;

  String? validateVin(String? vinNumber) {
    final s = S.of(context);

    if (vinNumber == null || vinNumber.trim().isEmpty) {
      return s.pleaseEnterVinNumber;
    }

    // Remove spaces and hyphens
    final vin = vinNumber.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();

    // VIN must contain exactly 17 characters
    if (vin.length != 17) {
      return s.vinMustContain17Characters;
    }

    // VIN allows A-Z and 0-9, but excludes I, O, Q
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

    if (!vinRegex.hasMatch(vin)) {
      return s.pleaseEnterAValidVinNumber;
    }

    return null;
  }

  Future<void> onSearchPressed() async {
    if (!(key.currentState?.validate() ?? false)) {
      return;
    }

    final vin = vinNumberController.text
        .replaceAll(RegExp(r'[\s-]'), '')
        .toUpperCase();

    Get.to(() => SearchVinView(vinNumber: vin));
  }
}
