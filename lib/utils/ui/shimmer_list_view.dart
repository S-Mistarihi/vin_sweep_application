import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  final int size;
  final double itemHeight;
  final double radius;
  final double spacing;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final bool scrollable;
  final Color baseColor;
  final Color heightlightColor;

  ShimmerListView({
    super.key,
    this.size = 10,
    this.itemHeight = 80,
    this.radius = 12,
    this.spacing = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.shrinkWrap = true,
    this.scrollable = false,
    Color? heightlightColor,
    Color? baseColor,
  }) : heightlightColor = heightlightColor ?? Colors.grey.shade200,
       baseColor = baseColor ?? Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: heightlightColor,
      child: ListView.separated(
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: scrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: size,
        separatorBuilder: (_, _) => SizedBox(height: spacing),
        itemBuilder: (_, _) => Container(
          height: itemHeight,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
