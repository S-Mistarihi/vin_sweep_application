import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.borderRadius = 4,
    this.fontSize = 16,
    this.labelColor,
    this.fontWeight = FontWeight.normal,
    this.size,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final double borderRadius;
  final double fontSize;
  final Color? labelColor;
  final FontWeight fontWeight;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final checkbox = Checkbox(
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      checkColor: checkColor ?? AppColors().baseColor,
      activeColor: activeColor ?? AppColors().cardCheckedBox,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(
        color: borderColor ?? AppColors().rememberBorderColor,
        width: 1,
      ),
    );

    final checkboxWidget = size == null
        ? checkbox
        : SizedBox(width: size, height: size, child: checkbox);

    if (label == null) {
      return checkboxWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        checkboxWidget,
        if (size != null) const SizedBox(width: 12),
        Text(
          label!,
          style: TextStyle(
            color: labelColor ?? AppColors().accentColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
