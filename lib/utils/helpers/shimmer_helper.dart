import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vin_sweep_application/utils/ui/shimmer_list_view.dart';

mixin ShimmerHelper {
  Widget getShimmerList({
    int size = 10,
    double itemHeight = 80,
    double radius = 12,
  }) => ShimmerListView(size: size, itemHeight: itemHeight, radius: radius);

  Widget getSimmerImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: CircleAvatar(backgroundColor: Colors.grey.shade400, radius: 20),
    );
  }
}
