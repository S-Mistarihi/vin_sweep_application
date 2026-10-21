import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/generated/l10n.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../utils/ui/common/custom_main_header.dart';
import '../../../../utils/ui/custom_checkbox.dart';
import '../../../../utils/ui/custom_dual_button.dart';
import '../controller/add_card_controller.dart';

class AddCardView extends StatefulWidget {
  const AddCardView({super.key, required this.mode});

  final AddCardMode mode;

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  late final AddCardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddCardController(widget.mode));
  }

  @override
  void dispose() {
    Get.delete<AddCardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).addCard,
            leftIcon: AppAssets().backIcon,
            size: 120,
          ),
          Positioned(
            top: 13.h,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    S.of(context).addCardInformation,
                    style: TextStyle(
                      color: AppColors().accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    S.of(context).cardInfo,
                    style: TextStyle(
                      color: AppColors().textFieldLabelColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CardField(
                    onCardChanged: (details) => controller.cardComplete.value =
                        details?.complete ?? false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors().textFieldBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: _buildOutlineInputBorder(),
                      focusedBorder: _buildOutlineInputBorder(),
                      enabledBorder: _buildOutlineInputBorder(),
                      hintText: 'Card Number  /  CVV  /  Expiry Date  ',
                      hintStyle: TextStyle(
                        color: AppColors().textFieldLabelColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (widget.mode == AddCardMode.subscribe)
                    Obx(
                      () => CustomCheckbox(
                        value: controller.saveCard.value,
                        onChanged: (v) => controller.saveCard.value = v,
                        label: S.of(context).saveCard,
                        activeColor: AppColors().firstHeaderShadowColor,
                        borderRadius: 5,
                        labelColor: AppColors().accentColor,
                      ),
                    ),
                  const Spacer(),
                  Obx(
                    () => CustomDualButton(
                      cancelText: S.of(context).cancelButton,
                      confirmText: controller.isLoading.value
                          ? '...'
                          : S.of(context).addCardButton,
                      onCancel: () => Get.back(),
                      onConfirm: controller.addCard,
                      cancelBackgroundColor: Colors.transparent,
                      cancelForegroundColor:
                          AppColors().buttonWithoutBackgroundText,
                      textSize: 18,
                      fontWeight: FontWeight.bold,
                      spacing: 8,
                      confirmOpacity:
                          controller.cardComplete.value &&
                              !controller.isLoading.value
                          ? 1
                          : 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
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
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: AppColors().textFieldBorderColor),
    );
  }
}
