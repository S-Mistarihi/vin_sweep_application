import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class CustomTabSwitcher extends StatelessWidget {
  const CustomTabSwitcher({
    super.key,
    required this.isLeftSelected,
    required this.leftLabel,
    required this.rightLabel,
    required this.onLeftTap,
    required this.onRightTap,
  });

  final bool isLeftSelected;
  final String leftLabel;
  final String rightLabel;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors().switcherBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment:
            isLeftSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 43.w,
              height: 4.5.h,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: _tab(label: leftLabel, onTap: onLeftTap)),
              Expanded(child: _tab(label: rightLabel, onTap: onRightTap)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: AppColors().accentColor, fontSize: 16),
        ),
      ),
    );
  }
}
