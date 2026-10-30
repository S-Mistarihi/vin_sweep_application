import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';

import '../../../../../../../configuration/app_colors.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../model/vehicle_response.dart';
import '../controller/general_info_controller.dart';
import 'vehicle_category_section.dart';

class GeneralInfoView extends StatelessWidget {
  const GeneralInfoView({super.key, required this.vehicleData});

  final List<VehicleDatum> vehicleData;

  @override
  Widget build(BuildContext context) {
    final GeneralInfoController controller = Get.put(GeneralInfoController());

    final engine = controller.getCategory(vehicleData, 'Engine');

    final general = controller.getCategory(vehicleData, 'General');

    final exteriorBody = controller.getCategory(vehicleData, 'Exterior / Body');

    final exteriorDimension = controller.getCategory(
      vehicleData,
      'Exterior / Dimension',
    );

    final passiveSaftey = controller.getCategory(
      vehicleData,
      'Passive Safety System',
    );

    final bagAir = controller.getCategory(
      vehicleData,
      'Passive Safety System / Air Bag Location',
    );

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
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

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: AppColors().switcherBackgroundColor,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                if (engine != null)
                  VehicleCategorySection(
                    category: engine,
                    iconName: AppAssets().engineIcon,
                  ),

                const SizedBox(height: 14),

                if (controller.isGeneralExpanded.value && general != null) ...[
                  VehicleCategorySection(
                    category: general,
                    iconName: AppAssets().generalIcon,
                  ),
                  const SizedBox(height: 14),
                  VehicleCategorySection(
                    category: exteriorBody!,
                    iconName: AppAssets().exteriorBodyIcon,
                  ),
                  const SizedBox(height: 14),
                  VehicleCategorySection(
                    category: exteriorDimension!,
                    iconName: AppAssets().exteriorDimensionIcon,
                  ),
                  const SizedBox(height: 14),
                  VehicleCategorySection(
                    category: passiveSaftey!,
                    iconName: AppAssets().passiveSafetyIcon,
                  ),
                  const SizedBox(height: 14),
                  VehicleCategorySection(
                    category: bagAir!,
                    iconName: AppAssets().airBagIcon,
                  ),
                ],

                SizedBox(height: 2.h),

                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: controller.toggleGeneralExpansion,
                    child: Text(
                      controller.isGeneralExpanded.value
                          ? S.of(context).collapse
                          : S.of(context).expanded,
                      style: TextStyle(
                        color: AppColors().smallTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}
