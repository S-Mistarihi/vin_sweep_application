import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomTextFormField {
  CustomTextFormField._local();

  static final CustomTextFormField _shared = CustomTextFormField._local();

  factory CustomTextFormField() => _shared;

  Widget buildCustomTextFormField({
    required TextEditingController controller,
    required FocusNode focusNode,
    String? errorText,
    required void Function(String) onFieldSubmitted,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    required List<TextInputFormatter> inputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
    bool readOnly = false,
    String? initialValue,
    String? Function(String?)? validator,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      textCapitalization: textCapitalization,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      obscuringCharacter: '*',
      autofocus: false,
      maxLines: 1,
      autocorrect: true,
      enableSuggestions: false,
      enableInteractiveSelection: false,
      readOnly: readOnly,
      initialValue: initialValue,
      style: TextStyle(color: AppColors().accentColor, fontSize: 14),
      scrollPadding: EdgeInsets.all(30),
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText,
        errorStyle: TextStyle(color: AppColors().errorText, fontSize: 14),
        hintStyle: TextStyle(color: AppColors().textFieldLabelColor, fontSize: 14),
        filled: true,
        fillColor: AppColors().textFieldBackgroundColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        suffixIcon: suffixIcon,
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
