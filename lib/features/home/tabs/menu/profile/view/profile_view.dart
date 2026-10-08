import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/profile/controller/profile_controller.dart';
import 'package:vin_sweep_application/utils/ui/custom_text_form_field.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../../../configuration/current_session.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/ui/common/custom_copyright.dart';
import '../../../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../../../utils/ui/custom_button.dart';
import '../../../../../../utils/ui/custom_field_label.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final ProfileController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: 'Profile',
            headerSubText: 'You can only edit your name and ZIP code',
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
                  SizedBox(height: 3.h),
                  Form(
                    key: _key,
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
                          onFieldSubmitted: (value) =>
                              controller.zipCodeFocusNode.requestFocus(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                        ),
                        SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().emailIconTextField,
                          text: S.of(context).emailLabel,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: null,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                CurrentSession().getUser()?.user?.email ?? '',
                            filled: true,
                            fillColor: Color(0xffE9F1F5),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            border: _buildOutlineInputBorder(),
                            enabledBorder: _buildOutlineInputBorder(),
                            focusedBorder: _buildOutlineInputBorder(),
                            disabledBorder: _buildOutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().icPhone,
                          text: S.of(context).phoneLabel,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField().buildCustomTextFormField(
                          controller: controller.phoneController,
                          focusNode: controller.phoneFocusNode,
                          onFieldSubmitted: (value) =>
                              controller.zipCodeFocusNode.requestFocus(),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        SizedBox(height: 24),
                        CustomFieldLabel(
                          icon: AppAssets().zipIconTextField,
                          text: S.of(context).zipCodeLabel,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField().buildCustomTextFormField(
                          controller: controller.zipCodeController,
                          focusNode: controller.zipCodeFocusNode,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        controller.onSavePressed();
                      }
                    },
                    text: 'Save',
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 156,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 3.h),
                  const CustomCopyright(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(26),
      borderSide: BorderSide(color: AppColors().textFieldBorderColor, width: 1),
    );
  }
}
