import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/common/custom_copyright.dart';
import '../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../../../utils/ui/custom_field_label.dart';
import '../../../../utils/ui/custom_text_form_field.dart';
import '../controller/forgot_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key, required this.token});

  final String token;
  final ForgotPasswordController controller = Get.find();
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
                'Please fill in your information below to reset your password',
            leftIcon: AppAssets().closeIcon,
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
                  SizedBox(height: 20),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomFieldLabel(
                          icon: AppAssets().passwordIconTextField,
                          text: S.of(context).newPasswordLabel,
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.newPasswordController,
                            focusNode: controller.newPasswordFocusNode,
                            errorText: controller.newPasswordError.value,
                            onFieldSubmitted: (value) => controller
                                .confirmPasswordFocusNode
                                .requestFocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            obscureText: controller.isPasswordObsecured.value,
                            suffixIcon: IconButton(
                              onPressed: controller.changePasswordVisibility,
                              icon: SvgPicture.asset(
                                controller.isPasswordObsecured.value
                                    ? AppAssets().eyeHideIconTextField
                                    : AppAssets().eyeIconTextField,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().passwordIconTextField,
                          text: S.of(context).confirmPasswordLabel,
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.confirmPasswordController,
                            focusNode: controller.confirmPasswordFocusNode,
                            errorText: controller.confirmPasswordError.value,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            obscureText: controller.isPasswordObsecured.value,
                            suffixIcon: IconButton(
                              onPressed: controller.changePasswordVisibility,
                              icon: SvgPicture.asset(
                                controller.isPasswordObsecured.value
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
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        controller.onResetSubmitPressed(token);
                      }
                    },
                    text: S.of(context).submitOtpButton,
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 156,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 3.h),
                  const CustomCopyright(),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
