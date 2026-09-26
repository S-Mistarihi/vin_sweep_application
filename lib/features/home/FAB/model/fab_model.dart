import 'dart:ui';

class FabModel {
  final String assetPath;
  final VoidCallback onTap;
  final double iconScale;

  const FabModel({
    required this.assetPath,
    required this.onTap,
    this.iconScale = 1,
  });
}
