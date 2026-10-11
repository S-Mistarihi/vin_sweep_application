import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.textSize,
    required this.fontWeight,
    required this.horizontalPadding,
    required this.verticalPadding,
    this.borderColor,
  });

  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double textSize;
  final FontWeight fontWeight;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        side: BorderSide(color: borderColor ?? Color(0xff1D416F), width: 1.5),
        alignment: Alignment.center,
        textStyle: TextStyle(fontSize: textSize, fontWeight: fontWeight),
        enableFeedback: true,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      child: Text(text),
    );
  }
}
