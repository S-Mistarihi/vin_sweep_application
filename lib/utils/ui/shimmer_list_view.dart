import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerListView extends StatelessWidget {
  final int size;
  final Color baseColor;
  final Color heightlightColor;

  ShimmerListView({
    super.key,
    this.size = 10,
    Color? heightlightColor,
    Color? baseColor,
  }) : heightlightColor = heightlightColor ?? Colors.grey.shade200,
       baseColor = baseColor ?? Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        return _shimmerItem();
      },
      itemCount: size,
      shrinkWrap: true,
    );
  }

  Widget _shimmerItem() {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: heightlightColor,
      child: Container(
        width: 100.w,
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
