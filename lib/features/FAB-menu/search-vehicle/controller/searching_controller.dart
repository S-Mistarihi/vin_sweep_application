import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../../utils/ui/custom_snakbar.dart';
import '../model/vehicle_response.dart';
import '../repository/vehicle_repository.dart';
import '../view/searching_result.dart';

class SearchingController extends GetxController {
  final String vinNumber;

  final RxBool isLoading = true.obs;

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

    isLoading.value = false;

    switch (result) {
      case Failure(:final exception):
        Get.back(); // user backed to enterVinScreen
        _showError(exception.message);

      case Success(:final data):
        //search registered --> updated LatestScreen
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().loadScans();
        }

        Get.off(
          () => SearchingResult(
            vinNumber: vinNumber,
            vehicleData: data.vehicleData,
            pdfReports: data.pdfReports,
            vehicleName: _getVehicleName(data.vehicleData),
            vehicleType: _getVehicleType(data.vehicleData),
          ),
          transition: Transition.downToUp,
        );
    }
  }

  void _showError(String? message) {
    CustomSnakbar.error(
      S.of(Get.context!).warning,
      message,
      fallback: S.of(Get.context!).incorrectVinNumber,
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
