import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/common/custom_main_sub_header.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../../../utils/ui/custom_text_form_field.dart';
import '../controller/scan_vin_controller.dart';

class ScanVinView extends StatefulWidget {
  const ScanVinView({super.key, required this.initialVin});

  final String initialVin;

  @override
  State<ScanVinView> createState() => _ScanVinViewState();
}

class _ScanVinViewState extends State<ScanVinView> {
  late final ScanVinController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ScanVinController(widget.initialVin));
  }

  @override
  void dispose() {
    Get.delete<ScanVinController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainSubHeader(
            headerSpace: 25,
            headerMainText: S.of(context).scanVehicleVinNumber,
            headerSubText: S
                .of(context)
                .scanYourVehicleVinNumberThroughTheCamera,
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
                          S.of(context).scannedVinNumberLabel,
                          style: TextStyle(
                            color: AppColors().textFieldLabelColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => CustomTextFormField().buildCustomTextFormField(
                            controller: controller.vinNumberController,
                            focusNode: controller.vinNumberNode,
                            textCapitalization: TextCapitalization.characters,
                            onFieldSubmitted: (value) =>
                                FocusScope.of(context).unfocus(),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(17),
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-z0-9]'),
                              ),
                            ],
                            errorText: controller.errorText.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      controller.rescan();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors().buttonWithoutBackgroundText,
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 143,
                        vertical: 14,
                      ),
                      side: BorderSide(
                        color: AppColors().buttonWithoutBackgroundText,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      textStyle: TextStyle(fontSize: 20),
                      enableFeedback: true,
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets().rescanIcon,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).rescanButton,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      controller.search();
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
