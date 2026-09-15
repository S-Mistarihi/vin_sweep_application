import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/api/system_config/controller/system_config_controller.dart';
import 'package:vin_sweep_application/utils/ui/progress_hud.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<SystemConfigController>(
        init: SystemConfigController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ProgressHud.shared.startLoading(context);
            });
            return SizedBox.shrink();
          }
          if (!controller.isLoading.value) {
            ProgressHud.shared.stopLoading();
          }
          controller.navigateToNextScreen();
          return SizedBox.shrink();
        },
      ),
    );
  }
}
