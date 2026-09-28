import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/FAB/search-vehicle/view/switcher/general-info/view/vehicle_detail_item.dart';

import '../../../../model/vehicle_response.dart';


class VehicleCategorySection extends StatelessWidget {
  const VehicleCategorySection({
    super.key,
    required this.category,
  });

  final VehicleDatum category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.category,
          style:  TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors().accentColor
          ),
        ),

        const SizedBox(height: 16),

        ...category.values.map(
              (item) => VehicleDetailItem(
            title: item.key,
            value: item.value,
          ),
        ),
      ],
    );
  }
}