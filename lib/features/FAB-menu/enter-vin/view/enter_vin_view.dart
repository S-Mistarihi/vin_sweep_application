import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../../../utils/ui/custom_text_form_field.dart';
import '../controller/enter_vin_controller.dart';

class EnterVinView extends StatelessWidget {
  EnterVinView({super.key});

  final EnterVinController controller = Get.put(EnterVinController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: 'Enter Vehicle VIN Number',
            headerSubText:
                'Enter the vehicle VIN number, it is a serial number and contains 17 character alphanumeric',
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
                  SizedBox(height: 3.h),
                  Form(
                    key: controller.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).vinNumberLabel,
                          style: TextStyle(
                            color: AppColors().textFieldLabelColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),

                        CustomTextFormField().buildCustomTextFormField(
                          controller: controller.vinNumberController,
                          focusNode: controller.vinNumberNode,
                          validator: controller.validateVin,
                          textCapitalization: TextCapitalization.characters,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(17),
                          ],
                          hintText: 'e.g. 1HGCM82633A004352',
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      controller.onSearchPressed();
                    },
                    text: S.of(context).searchLabel,
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 150,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
