import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vin_sweep_application/api/system_config/model/system_config_response.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/cache_keys.dart';
import 'package:vin_sweep_application/features/auth/auth_view.dart';
import 'package:vin_sweep_application/features/intro/view/intro_screen.dart';

import '../../../configuration/app_config.dart';
import '../../../utils/helpers/common/repository_result.dart';
import '../repository/system_config_repository.dart';

class SystemConfigController extends GetxController {
  final RxList<SystemConfigModel> _list = <SystemConfigModel>[].obs;
  final RxBool isLoading = false.obs;

  RxList<SystemConfigModel> get list => _list;

  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();

    prefs = Get.find<SharedPreferences>();
    _getSystemConfig();
  }

  void _getSystemConfig() async {
    try {
      isLoading.value = true;
      SystemConfigRepository repository = AppConfig().isDemo
          ? DemoSystemConfigRepository()
          : ApiSystemConfigRepository(url: ApiEndPoints.sysConfig);
      await Future.delayed(Duration(seconds: 4));
      final result = await repository.getSystemConfig(context: Get.context!);
      isLoading.value = false;

      switch (result) {
        case Success(:final data):
          _list.assignAll(data.result!);
          break;

        case Failure(:final exception):
          Get.snackbar('Error', exception.toString());
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong $e');
    }
  }

  void navigateToNextScreen() async {
    bool isSkipIntro = await _getIntroStatus();
    Get.to(() => isSkipIntro ? AuthView() : IntroScreen());
  }

  Future<bool> _getIntroStatus() async =>
      prefs.getBool(CacheKeys.isSkipIntro) ?? false;
}
