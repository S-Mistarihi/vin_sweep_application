import 'package:flutter/material.dart';
import 'package:vin_sweep_application/utils/ui/shimmer_box.dart';

class ActivePlanSkeleton extends StatelessWidget {
  const ActivePlanSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerScope(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header: icon + title/subtitle + badge
          Row(
            children: [
              ShimmerBox(width: 38, height: 38, radius: 16),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 110, height: 16),
                    SizedBox(height: 6),
                    ShimmerBox(width: 80, height: 12),
                  ],
                ),
              ),
              ShimmerBox(width: 56, height: 22, radius: 12),
            ],
          ),
          Spacer(),
          // progress bar
          ShimmerBox(height: 8),
          SizedBox(height: 8),
          // stats row
          Row(
            children: [
              ShimmerBox(width: 70, height: 14),
              Spacer(),
              ShimmerBox(width: 36, height: 14),
            ],
          ),
        ],
      ),
    );
  }
}
