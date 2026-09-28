import 'package:flutter/material.dart';

import '../../../../../../configuration/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../enter-vin/model/vehicle_response.dart';

class VehicleCategorySection extends StatelessWidget {
  const VehicleCategorySection({super.key, required this.category});

  final VehicleDatum category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.category,
          style: TextStyle(
            color: AppColors().accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 16),

        ...category.values.map(
          (item) => VehicleDetailItem(title: item.key, value: item.value),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

class VehicleDetailItem extends StatelessWidget {
  const VehicleDetailItem({super.key, required this.title, this.value});

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors().textFieldLabelColor,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors().textFieldBackgroundColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            hasValue
                ? value!
                : S.of(context).informationNotAvailableForThisDetail,
            style: TextStyle(
              fontSize: 14,
              color: hasValue
                  ? AppColors().accentColor
                  : AppColors().errorDialogColor,
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
