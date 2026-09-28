import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home-fab/enter-vin/model/vehicle_response.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/view/search_vin_result_view.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../enter-vin/repository/enter_vin_repository.dart';

enum SearchMode { info, report }

class SearchVinController extends GetxController {
  final Rx<SearchMode> searchMode = SearchMode.info.obs;

  final RxBool isLoading = true.obs;

  final String vinNumber;

  late final List<VehicleDatum> vehicleData;

  final RxBool isGeneralExpanded = false.obs;

  SearchVinController({required this.vinNumber});

  @override
  void onInit() {
    super.onInit();
    searchVinNumber();
  }

  void toggleGeneralExpansion() {
    isGeneralExpanded.toggle();
  }

  Future<void> searchVinNumber() async {
    final context = Get.context!;

    final result = await createEnterVinRepository().scanVin(
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
          () => SearchVinResultView(
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

  List<VehicleDatum> getCategories(
    List<VehicleDatum> data,
    List<String> categoryNames,
  ) {
    return data.where((item) {
      return categoryNames.any(
        (name) =>
            item.category.trim().toLowerCase() == name.trim().toLowerCase(),
      );
    }).toList();
  }

  String _getVehicleName(List<VehicleDatum> data) {
    final general = getCategoryFromData(data, 'General');

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
    final general = getCategoryFromData(data, 'General');

    if (general == null) {
      return null;
    }

    final type = _valueOf(general, 'vehicle type');

    return type.isEmpty ? null : type;
  }

  VehicleDatum? getCategoryFromData(
    List<VehicleDatum> data,
    String categoryName,
  ) {
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
      return data.values.firstWhere((e) => e.key.toLowerCase() == key).value ??
          '';
    } catch (_) {
      return '';
    }
  }

  bool get isInfo => searchMode.value == SearchMode.info;

  bool get isReport => searchMode.value == SearchMode.report;

  void switchSearchMode(SearchMode mode) {
    if (searchMode.value == mode) return;

    searchMode.value = mode;
  }

  void switchToInfo() {
    switchSearchMode(SearchMode.info);
  }

  void switchToReport() {
    switchSearchMode(SearchMode.report);
  }
}
