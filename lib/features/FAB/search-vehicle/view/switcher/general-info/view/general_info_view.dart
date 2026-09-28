import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../configuration/app_colors.dart';
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
              'This section includes free data like make, model, engine type, and body style.',
              style: TextStyle(color: AppColors().accentColor, fontSize: 15),
            ),
          ),

          SizedBox(height: 3.h),

          if (engine != null) VehicleCategorySection(category: engine),

          const SizedBox(height: 14),

          if (controller.isGeneralExpanded.value && general != null) ...[
            VehicleCategorySection(category: general),
          ],

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: controller.toggleGeneralExpansion,
              child: Text(
                controller.isGeneralExpanded.value
                    ? '˄  Collapse'
                    : '˅  Expanded',
                style: TextStyle(
                  color: AppColors().smallTextColor,
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
