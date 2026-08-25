import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/screens/home/tabs/menu/change_password/controller/change_password_controller.dart';

import '../../../../../../configuration/app_colors.dart';
import '../../../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../../../utils/ui/custom_button.dart';
import '../../../../../../utils/ui/custom_field_label.dart';
import '../../../../../../utils/ui/custom_text_form_field.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: 'Change Password',
            headerSubText:
                'Please enter your current password and new password',
            leftIcon: AppAssets().backIcon,
          ),
          Positioned(
            top: 25.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        CustomFieldLabel(
                          icon: AppAssets().passwordIconTextField,
                          text: 'Current Password',
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.currentPasswordController,
                            focusNode: controller.currentPasswordFocusNode,
                            errorText: controller.currentPasswordError.value,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            obscureText: controller.isPasswordObscured.value,
                            suffixIcon: IconButton(
                              onPressed: controller.changePasswordVisibility,
                              icon: SvgPicture.asset(
                                controller.isPasswordObscured.value
                                    ? AppAssets().eyeHideIconTextField
                                    : AppAssets().eyeIconTextField,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().passwordIconTextField,
                          text: 'New Password',
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.currentPasswordController,
                            focusNode: controller.currentPasswordFocusNode,
                            errorText: controller.currentPasswordError.value,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            obscureText: controller.isPasswordObscured.value,
                            suffixIcon: IconButton(
                              onPressed: controller.changePasswordVisibility,
                              icon: SvgPicture.asset(
                                controller.isPasswordObscured.value
                                    ? AppAssets().eyeHideIconTextField
                                    : AppAssets().eyeIconTextField,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().passwordIconTextField,
                          text: 'Re-Type New Password',
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.currentPasswordController,
                            focusNode: controller.currentPasswordFocusNode,
                            errorText: controller.currentPasswordError.value,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            obscureText: controller.isPasswordObscured.value,
                            suffixIcon: IconButton(
                              onPressed: controller.changePasswordVisibility,
                              icon: SvgPicture.asset(
                                controller.isPasswordObscured.value
                                    ? AppAssets().eyeHideIconTextField
                                    : AppAssets().eyeIconTextField,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  CustomButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        controller.onChangePressed();
                      }
                    },
                    text: 'Change',
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 156,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 3.h),
                  SvgPicture.asset(
                    AppAssets().copyRightIcon,
                    width: 212,
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
