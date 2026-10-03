import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configuration/app_colors.dart';

class CustomTextField {
  CustomTextField._local();

  static final CustomTextField _shared = CustomTextField._local();

  factory CustomTextField() => _shared;

  Widget buildCustomTextField({
    required TextEditingController controller,
    required void Function(String)? onChanged,
    required String hintText,
    required String iconNameAsset,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: TextStyle(color: AppColors().accentColor, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors().textFieldLabelColor,
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors().textFieldBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(iconNameAsset),
        ),
        border: _buildTextFormFieldBorder(),
        enabledBorder: _buildTextFormFieldBorder(),
        focusedBorder: _buildTextFormFieldBorder(),
        errorBorder: _buildTextFormFieldBorder(),
        focusedErrorBorder: _buildTextFormFieldBorder(),
      ),
    );
  }

  OutlineInputBorder _buildTextFormFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(26),
      borderSide: BorderSide(color: AppColors().textFieldBorderColor, width: 1),
    );
  }
}
