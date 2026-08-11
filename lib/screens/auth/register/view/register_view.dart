import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/screens/auth/register/controller/register_controller.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/custom_field_label.dart';
import '../../../../utils/ui/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final RegisterController controller = Get.put(RegisterController());
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _registerKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              CustomFieldLabel(
                icon: AppAssets().nameIconTextField,
                text: S.of(context).nameLabel,
              ),
              const SizedBox(height: 8),
              CustomTextFormField().buildCustomTextFormField(
                controller: controller.nameController,
                focusNode: controller.nameFocusNode,
                errorText: controller.nameError.value,
                onFieldSubmitted: (value) =>
                    controller.emailFocusNode.requestFocus(),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
              ),
              const SizedBox(height: 24),
              CustomFieldLabel(
                icon: AppAssets().emailIconTextField,
                text: S.of(context).emailLabel,
              ),
              const SizedBox(height: 8),
              CustomTextFormField().buildCustomTextFormField(
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                errorText: controller.emailError.value,
                onFieldSubmitted: (value) =>
                    controller.passwordFocusNode.requestFocus(),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                  onFieldSubmitted: (value) =>
                      controller.zipCodeFocusNode.requestFocus(),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
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
              const SizedBox(height: 24),
              CustomFieldLabel(
                icon: AppAssets().zipIconTextField,
                text: S.of(context).zipCodeLabel,
              ),
              const SizedBox(height: 8),
              CustomTextFormField().buildCustomTextFormField(
                controller: controller.zipCodeController,
                focusNode: controller.zipCodeFocusNode,
                errorText: controller.zipCodeError.value,
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [LengthLimitingTextInputFormatter(5)],
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        CustomButton(
          onPressed: () {
            if (_registerKey.currentState!.validate()) {
              controller.onRegisterPressed();
            }
          },
          text: S.of(context).registerButton,
          backgroundColor: AppColors().buttonWithBackground,
          foregroundColor: AppColors().buttonWithBackgroundText,
          textSize: 20,
          fontWeight: FontWeight.bold,
          horizontalPadding: 143,
          verticalPadding: 12,
        ),
        SizedBox(height: 1.5.h),
        SvgPicture.asset(AppAssets().copyRightIcon, width: 212, height: 12),
        SizedBox(height: 20,)
      ],
    );
  }
}
