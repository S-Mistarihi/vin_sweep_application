import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/view/general-info/view/vehicle_category_section.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../enter-vin/model/vehicle_response.dart';
import '../../../controller/search_vin_controller.dart';

class GeneralInfoView extends StatelessWidget {
  const GeneralInfoView({
    super.key,
    required this.categories,
    required this.controller,
  });

  final List<VehicleDatum> categories;
  final SearchVinController controller;

  @override
  Widget build(BuildContext context) {
    final engine = controller.getCategoryFromData(categories, 'Engine');
    final general = controller.getCategoryFromData(categories, 'General');
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors().generalInfoContainerBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors().generalInfoContainerBorder,
                width: 2,
              ),
            ),
            child: Text(
              S.of(context).thisSectionIncludesFreeDataLikeMakeModelEngineType,
              style: TextStyle(color: AppColors().accentColor, fontSize: 15),
            ),
          ),

          SizedBox(height: 3.h),

          if (engine != null) VehicleCategorySection(category: engine),

          const SizedBox(height: 8),

          if (controller.isGeneralExpanded.value && general != null) ...[
            VehicleCategorySection(category: general),
          ],

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: controller.toggleGeneralExpansion,
              child: Text(
                controller.isGeneralExpanded.value
                    ? S.of(context).collapse
                    : S.of(context).expanded,
                style: TextStyle(
                  color: AppColors().buttonWithBackground,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
