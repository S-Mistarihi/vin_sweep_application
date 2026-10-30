import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/switcher/general-info/view/vehicle_detail_item.dart';

import '../../../../model/vehicle_response.dart';

class VehicleCategorySection extends StatelessWidget {
  const VehicleCategorySection({
    super.key,
    required this.category,
    required this.iconName,
  });

  final VehicleDatum category;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(iconName),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.category,
                softWrap: true,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors().accentColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Divider(
          color: AppColors().switcherBackgroundColor,
          thickness: 2,
          height: 2,
        ),

        const SizedBox(height: 16),

        ...category.values.map(
          (item) => VehicleDetailItem(title: item.key, value: item.value),
        ),
      ],
    );
  }
}
