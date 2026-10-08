import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    final switcher = Switch(
      value: value,
      onChanged: onChanged,
      inactiveTrackColor:
          inactiveTrackColor ?? AppColors().inactiveTrackSwitchColor,
      inactiveThumbColor: thumbColor ?? AppColors().baseColor,
      activeTrackColor: activeTrackColor ?? AppColors().firstHeaderShadowColor,
      activeThumbColor: thumbColor ?? AppColors().baseColor,
    );

    if (label == null) {
      return switcher;
    }

    return Row(
      children: [
        Text(
          label!,
          style: TextStyle(color: AppColors().accentColor, fontSize: 16),
        ),
        const Spacer(),
        switcher,
      ],
    );
  }
}
