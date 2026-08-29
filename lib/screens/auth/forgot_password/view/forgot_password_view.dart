import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/screens/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:vin_sweep_application/screens/auth/forgot_password/view/change_password_view.dart';
import 'package:vin_sweep_application/utils/ui/custom_field_label.dart';
import 'package:vin_sweep_application/utils/ui/custom_text_form_field.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../otp/controller/otp_controller.dart';
import '../../otp/model/verify_otp_response.dart';
import '../../otp/view/otp_view.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: 'Forgot Password',
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
                  SizedBox(height: 24),
                  Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomFieldLabel(
                          icon: AppAssets().emailIconTextField,
                          text: S.of(context).emailLabel,
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.emailController,
                            focusNode: controller.emailFocusNode,
                            errorText: controller.emailError.value,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      controller.onSubmitEmailPressed(context, () {
                        _buildEmailCheckDialog(context);
                      });
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
                  SvgPicture.asset(
                    AppAssets().copyRightIcon,
                    width: 212,
                    height: 12,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildEmailCheckDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors().baseColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      isScrollControlled: true,
      constraints: BoxConstraints(minHeight: 74.8.h, maxHeight: 76.h),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4.h),
              InkWell(
                onTap: () => Get.back(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(AppAssets().closeIcon),
                ),
              ),
              SizedBox(height: 8.h),
              SvgPicture.asset(AppAssets().emailBottomSheet),
              SizedBox(height: 5.h),
              Text(
                'Please Check your Email',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors().accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'An email with a new password has been sent to you, please check junk folder if you didn’t find it in inbox.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors().textFieldLabelColor,
                ),
              ),
              SizedBox(height: 5.h),
              CustomButton(
                onPressed: () {
                  _goToOtpView();
                },
                text: 'Done',
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
              SizedBox(height: 3.h),
            ],
          ),
        );
      },
    );
  }

  void _goToOtpView() {
    Get.back();

    if (Get.isRegistered<OtpController>()) {
      Get.delete<OtpController>();
    }

    Get.to(
      () => OtpView(
        email: controller.emailController.text.trim(),
        type: OtpType.passwordReset,

        onSuccess: (token) {
          Get.off(() => ChangePasswordView(token: token));
        },
      ),
    );
  }
}
