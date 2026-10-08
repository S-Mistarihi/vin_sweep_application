import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

class CustomDualButton extends StatelessWidget {
  const CustomDualButton({
    super.key,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    this.cancelBackgroundColor,
    this.cancelForegroundColor,
    this.textSize = 20,
    this.fontWeight = FontWeight.normal,
    this.spacing = 14,
    this.confirmOpacity = 1,
  });

  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  final Color? cancelBackgroundColor;
  final Color? cancelForegroundColor;

  final double textSize;
  final FontWeight fontWeight;
  final double spacing;

  final double confirmOpacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: onCancel,
            text: cancelText,
            backgroundColor:
                cancelBackgroundColor ?? AppColors().buttonWithoutBackground,
            foregroundColor:
                cancelForegroundColor ??
                AppColors().buttonWithoutBackgroundText,
            textSize: textSize,
            fontWeight: fontWeight,
            horizontalPadding: 60,
            verticalPadding: 13,
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Opacity(
            opacity: confirmOpacity,
            child: CustomButton(
              onPressed: onConfirm,
              text: confirmText,
              backgroundColor: AppColors().buttonWithBackground,
              foregroundColor: AppColors().buttonWithBackgroundText,
              textSize: textSize,
              fontWeight: fontWeight,
              horizontalPadding: 60,
              verticalPadding: 13,
            ),
          ),
        ),
      ],
    );
  }
}
