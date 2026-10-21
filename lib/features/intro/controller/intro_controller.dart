import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/cache_keys.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';
import 'package:vin_sweep_application/features/auth/auth_view.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import '../model/intro_model.dart';

class IntroController extends GetxController {
  final controller = PageController();
  final RxInt _page = 0.obs;

  RxInt get page => _page;

  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();

    prefs = Get.find<SharedPreferences>();
    _fillData();
  }

  void _fillData() {
    CurrentSession().intro = [
      IntroModel(
        image: AppAssets().introScreen1,
        title: S.of(Get.context!).titleIntro1,
        description: S.of(Get.context!).descriptionIntro1,
      ),
      IntroModel(
        image: AppAssets().introScreen2,
        title: S.of(Get.context!).titleIntro2,
        description: S.of(Get.context!).descriptionIntro2,
      ),
      IntroModel(
        image: AppAssets().introScreen3,
        title: S.of(Get.context!).titleIntro3,
        description: S.of(Get.context!).descriptionIntro3,
      ),
    ];
  }

  void onPageChanged(int index) {
    _page.value = index;
  }

  void nextPage() {
    if (_page.value < CurrentSession().intro.length - 1) {
      controller.animateToPage(
        _page.value + 1,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    } else {
      finishIntro();
    }
  }

  void previousPage() {
    if (_page.value > 0) {
      controller.animateToPage(
        _page.value - 1,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  void skipIntro() {
    finishIntro();
  }

  Future<void> finishIntro() async {
    await prefs.setBool(CacheKeys.isSkipIntro, true);
    Get.off(() => AuthView());
  }

  bool get isLastPage {
    return _page.value == CurrentSession().intro.length - 1;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
