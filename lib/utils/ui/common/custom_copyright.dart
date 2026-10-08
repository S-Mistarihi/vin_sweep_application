import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';

class CustomCopyright extends StatelessWidget {
  const CustomCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssets().copyRightIcon, width: 212, height: 12);
  }
}
