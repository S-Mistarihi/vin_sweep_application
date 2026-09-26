import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vin_sweep_application/features/home/FAB/model/fab_model.dart';

class SubActionButton extends StatelessWidget {
  const SubActionButton({
    super.key,
    required this.action,
    required this.size,
    required this.onPressed,
  });

  final FabModel action;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(action.assetPath, fit: BoxFit.contain),
      ),
    );
  }
}
