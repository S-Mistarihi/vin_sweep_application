import 'package:get/get.dart';

import '../../../../model/vehicle_response.dart';

class GeneralInfoController extends GetxController {
  final RxBool isGeneralExpanded = false.obs;

  void toggleGeneralExpansion() {
    isGeneralExpanded.toggle();
  }

  VehicleDatum? getCategory(
    List<VehicleDatum> vehicleData,
    String categoryName,
  ) {
    try {
      return vehicleData.firstWhere(
        (item) =>
            item.category.trim().toLowerCase() ==
            categoryName.trim().toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }
}
