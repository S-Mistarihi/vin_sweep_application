import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/screens/auth/auth_screen.dart';
import '../../../generated/l10n.dart';
import '../model/intro_model.dart';

class IntroController extends GetxController {
  final controller = PageController();

  final List<IntroModel> _screens = [];

  List<IntroModel> get screens => _screens;

  final RxInt _page = 0.obs;

  RxInt get page => _page;

  final SharedPreferences prefs = Get.find<SharedPreferences>();

  void fillData(BuildContext context) {
    _screens.clear();
    final s = S.of(context);
    _screens.add(
      IntroModel(
        image: AppAssets().introScreen1,
        title: s.titleIntro1,
        description: s.descriptionIntro1,
      ),
    );
    _screens.add(
      IntroModel(
        image: AppAssets().introScreen2,
        title: s.titleIntro2,
        description: s.descriptionIntro2,
      ),
    );
    _screens.add(
      IntroModel(
        image: AppAssets().introScreen3,
        title: s.titleIntro3,
        description: s.descriptionIntro3,
      ),
    );
  }

  void onPageChanged(int index) {
    _page.value = index;
  }

  void nextPage() {
    if (controller.page! < _screens.length - 1) {
      controller.animateToPage(
        (controller.page! + 1).toInt(),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    } else {
      goToAuth();
    }
  }

  void previousPage() {
    if (controller.page! > 0) {
      controller.animateToPage(
        (controller.page! - 1).toInt(),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  void skip() {
    goToAuth();
  }

  Future<void> _saveOnboardingScreenStatus() async {
    await prefs.setBool('isSkipIntro', true);
  }

  Future<void> goToAuth() async {
    await _saveOnboardingScreenStatus();

    Get.off(() => AuthScreen());
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
