import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/screens/auth/register/view/register_view.dart';

import '../../generated/l10n.dart';
import '../../utils/ui/custom_auth_header.dart';
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

                      _buildAuthSwitcher(context),

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

  Widget _buildAuthSwitcher(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors().switcherBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: controller.isLogin
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 43.w,
              height: 4.5.h,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToLogin,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).loginSwitcher,
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToRegister,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).registerButton,
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
