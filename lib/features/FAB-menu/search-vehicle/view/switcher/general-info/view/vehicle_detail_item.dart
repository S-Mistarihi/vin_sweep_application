import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

import '../../../../../../../generated/l10n.dart';

class VehicleDetailItem extends StatelessWidget {
  const VehicleDetailItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null && value!.trim().isNotEmpty;

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
