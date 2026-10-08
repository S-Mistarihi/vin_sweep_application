import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_sub_header.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';
import '../../../../configuration/app_assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/common/custom_copyright.dart';
import '../../../../utils/ui/custom_field_label.dart';
import '../controller/otp_controller.dart';
import '../model/verify_otp_response.dart';

class OtpView extends StatelessWidget {
  final String email;
  final OtpType type;
  final ValueChanged<String> onSuccess;

  OtpView({
    super.key,
    required this.email,
    required this.type,
    required this.onSuccess,
  });

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: S.of(context).otpHeaderMainText,
            headerSubText: S.of(context).otpHeaderSubText,
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
                  const SizedBox(height: 32),
                  CustomFieldLabel(
                    icon: AppAssets().otpIconTextField,
                    text: S.of(context).otpCodeLabel,
                  ),
                  const SizedBox(height: 8),
                  MaterialPinField(
                    pinController: controller.otpTextController,
                    length: OtpController.otpLength,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.changeOtpValue(value);
                    },
                    onCompleted: (value) {
                      controller.changeOtpValue(value);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    theme: MaterialPinTheme(
                      shape: MaterialPinShape.outlined,
                      cellSize: Size(56, 64),
                      spacing: 2.w,
                      borderRadius: BorderRadius.circular(10),

                      borderWidth: 1,
                      focusedBorderWidth: 1,

                      fillColor: AppColors().textFieldBackgroundColor,
                      focusedFillColor: AppColors().textFieldBackgroundColor,
                      completeFillColor: AppColors().textFieldBackgroundColor,
                      filledFillColor: AppColors().textFieldBackgroundColor,

                      borderColor: AppColors().textFieldBorderColor,
                      focusedBorderColor: AppColors().smallTextColor,
                      completeBorderColor: AppColors().textFieldBorderColor,
                      filledBorderColor: AppColors().textFieldBorderColor,

                      animateCursor: true,
                      enableErrorShake: true,
                      errorAnimationDuration: Duration(seconds: 5),
                      entryAnimation: MaterialPinAnimation.fade,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => InkWell(
                      onTap: controller.remainingTime.value == 0
                          ? () {
                              controller.resendOtp(email, type);
                            }
                          : null,
                      child: Text(
                        S.of(context).resendCode,
                        style: TextStyle(
                          color: AppColors().resendTextColor,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors().resendTextColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final seconds = controller.remainingTime.value;
                    final minutes = seconds ~/ 60;
                    final remainingSeconds = seconds % 60;
                    return Text(
                      '(${minutes.toString().padLeft(2, '0')}:'
                      '${remainingSeconds.toString().padLeft(2, '0')})',
                      style: TextStyle(
                        color: AppColors().textFieldLabelColor,
                        fontSize: 15,
                      ),
                    );
                  }),
                  const Spacer(),
                  Obx(
                    () => CustomButton(
                      onPressed: controller.isVerifying.value
                          ? null
                          : () {
                              controller.verifyOtpPressed(
                                email: email,
                                type: type,
                                onSuccess: onSuccess,
                              );
                            },
                      text: controller.isVerifying.value
                          ? 'Verifing ...'
                          : S.of(context).submitOtpButton,
                      backgroundColor: AppColors().buttonWithBackground,
                      foregroundColor: AppColors().buttonWithBackgroundText,
                      textSize: 20,
                      fontWeight: FontWeight.bold,
                      horizontalPadding: 148,
                      verticalPadding: 12,
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  const CustomCopyright(),
                  SizedBox(height: 7.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
