import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/auth/register/view/register_view.dart';

import '../../generated/l10n.dart';
import '../../utils/ui/custom_auth_header.dart';
import '../../utils/ui/custom_tab_switcher.dart';
import 'auth_controller.dart';
import 'login/view/login_view.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            CustomAuthHeader(
              isLogin: controller.isLogin,
              headerSpace: controller.headerSpace,
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: controller.topPosition,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColors().baseColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      CustomTabSwitcher(
                        isLeftSelected: controller.isLogin,
                        leftLabel: S.of(context).loginSwitcher,
                        rightLabel: S.of(context).registerButton,
                        onLeftTap: controller.switchToLogin,
                        onRightTap: controller.switchToRegister,
                      ),

                      SizedBox(height: 5.h),

                      controller.isLogin ? LoginView() : RegisterView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
