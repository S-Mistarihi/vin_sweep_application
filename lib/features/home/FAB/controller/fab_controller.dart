import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FabController extends GetxController {
  final ValueNotifier<bool> speedDialNotifier = ValueNotifier(false);

  bool get isOpen => speedDialNotifier.value;

  void toggle() => speedDialNotifier.value = !speedDialNotifier.value;

  void open() => speedDialNotifier.value = true;

  void close() => speedDialNotifier.value = false;

  @override
  void onClose() {
    speedDialNotifier.dispose();
    super.onClose();
  }
}
