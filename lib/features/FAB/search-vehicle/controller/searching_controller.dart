import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/FAB/search-vehicle/view/searching_result.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../model/vehicle_response.dart';
import '../repository/vehicle_repository.dart';

class SearchingController extends GetxController {
  final String vinNumber;

  final RxBool isLoading = true.obs;

  late final List<VehicleDatum> vehicleData;

  SearchingController({required this.vinNumber});

  @override
  void onInit() {
    super.onInit();
    onSearchPressed();
  }

  Future<void> onSearchPressed() async {
    final context = Get.context!;

    final result = await createVehicleRepository().scanVin(
      context: context,
      vinNumber: vinNumber,
    );

    switch (result) {
      case Failure(:final exception):
        isLoading.value = false;
        _showError(exception.message);

      case Success(:final data):
        vehicleData = data;
        isLoading.value = false;

        Get.off(
          () => SearchingResult(
            vinNumber: vinNumber,
            vehicleData: data,
            vehicleName: _getVehicleName(data),
            vehicleType: _getVehicleType(data),
          ),
          transition: Transition.downToUp,
        );
    }
  }

  void _showError(String? message) {
    Get.snackbar(
      S.of(Get.context!).warning,
      message?.isNotEmpty == true ? message! : 'Incorrect vin number',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 10),
    );
  }

  VehicleDatum? getCategory(List<VehicleDatum> data, String categoryName) {
    try {
      return data.firstWhere(
        (item) =>
            item.category.trim().toLowerCase() ==
            categoryName.trim().toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  String _valueOf(VehicleDatum data, String key) {
    try {
      return data.values
              .firstWhere(
                (item) =>
                    item.key.trim().toLowerCase() == key.trim().toLowerCase(),
              )
              .value ??
          '';
    } catch (_) {
      return '';
    }
  }

  String _getVehicleName(List<VehicleDatum> data) {
    final general = getCategory(data, 'General');

    if (general == null) {
      return 'Unknown';
    }

    final year = _valueOf(general, 'model year');
    final make = _valueOf(general, 'make');
    final model = _valueOf(general, 'model');

    final name = '$year $make $model'.trim();

    return name.isEmpty ? 'Unknown' : name;
  }

  String? _getVehicleType(List<VehicleDatum> data) {
    final general = getCategory(data, 'General');

    if (general == null) {
      return null;
    }

    final type = _valueOf(general, 'vehicle type');

    return type.isEmpty ? null : type;
  }
}
