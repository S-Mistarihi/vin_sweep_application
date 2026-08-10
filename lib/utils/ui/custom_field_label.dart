import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomFieldLabel extends StatelessWidget {
  const CustomFieldLabel({super.key, required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: AppColors().textFieldLabelColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
