import 'package:flutter/material.dart';
import 'package:vin_sweep_application/utils/ui/progress_hud.dart';

import '../../configuration/app_colors.dart';

/// Centered app spinner.
class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.size = 50.0,
    this.color,
    this.isLoadMore = false,
  });

  final double size;
  final Color? color;
  final bool isLoadMore;

  @override
  Widget build(BuildContext context) {
    return ProgressHud.shared.getCircularProgressIndicator(
      color: color ?? AppColors().buttonWithBackground,
      size: size,
      isLoadMore: isLoadMore,
    );
  }
}

/// Full-screen dim layer with a spinner, shown while submitting.
class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black38,
      child: CustomLoadingIndicator(color: AppColors().buttonWithBackground),
    );
  }
}
