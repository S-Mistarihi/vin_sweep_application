import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/auth/forgot_password/view/forgot_password_view.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';
import 'package:vin_sweep_application/utils/ui/custom_field_label.dart';
import 'package:vin_sweep_application/utils/ui/custom_text_form_field.dart';

import '../../../../generated/l10n.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _loginKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              CustomFieldLabel(
                icon: AppAssets().emailIconTextField,
                text: S.of(context).emailLabel,
              ),
              const SizedBox(height: 8),
              Obx(
                () => CustomTextFormField().buildCustomTextFormField(
                  controller: controller.emailController,
                  focusNode: controller.emailFocusNode,
                  errorText: controller.emailError.value,
                  onFieldSubmitted: (value) =>
                      controller.passwordFocusNode.requestFocus(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                ),
              ),
              const SizedBox(height: 24),
              CustomFieldLabel(
                icon: AppAssets().passwordIconTextField,
                text: S.of(context).passwordLabel,
              ),
              const SizedBox(height: 8),
              Obx(
                () => CustomTextFormField().buildCustomTextFormField(
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  errorText: controller.passwordError.value,
                  onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isRememberMeChecked.value,
                    onChanged: (value) {
                      controller.changeRememberMeChecked(value ?? false);
                    },
                    checkColor: AppColors().rememberCheckedColor,
                    activeColor: AppColors().rememberBorderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(
                      color: AppColors().rememberBorderColor,
                      width: 1,
                    ),
                  ),
                ),
                Text(
                  S.of(context).rememberMeCheckbox,
                  style: TextStyle(
                    color: AppColors().rememberTextColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () =>
                  Get.to(ForgotPasswordView(), transition: Transition.downToUp),
              child: Text(
                S.of(context).fogotPasswordButton,
                style: TextStyle(
                  color: AppColors().smallTextColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        CustomButton(
          onPressed: () {
            if (_loginKey.currentState!.validate()) {
              controller.onLoginPressed();
            }
          },
          text: S.of(context).loginButton,
          backgroundColor: AppColors().buttonWithBackground,
          foregroundColor: AppColors().buttonWithBackgroundText,
          textSize: 20,
          fontWeight: FontWeight.bold,
          horizontalPadding: 156,
          verticalPadding: 12,
        ),
        SizedBox(height: 3.h),
        SvgPicture.asset(AppAssets().copyRightIcon, width: 212, height: 12),
      ],
    );
  }
}
