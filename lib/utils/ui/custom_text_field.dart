import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configuration/app_colors.dart';

class CustomTextField {
  CustomTextField._local();

  static final CustomTextField _shared = CustomTextField._local();

  factory CustomTextField() => _shared;

  Widget buildCustomTextField({
    required TextEditingController controller,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    required String hintText,
    String? iconNameAsset,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: TextStyle(color: AppColors().accentColor, fontSize: 14),
      textCapitalization: textCapitalization,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors().textFieldLabelColor,
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors().textFieldBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: iconNameAsset != null
            ? Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(iconNameAsset),
              )
            : Icon(Icons.discount, color: AppColors().textFieldLabelColor),
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
