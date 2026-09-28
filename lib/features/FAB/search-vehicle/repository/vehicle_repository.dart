import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';
import '../model/vehicle_response.dart';

abstract class VehicleRepository {
  Future<RepositoryResult<List<VehicleDatum>>> scanVin({
    required BuildContext context,
    required String vinNumber,
    bool showLoading = false,
  });
}

class ApiVehicleRepository extends VehicleRepository {
  @override
  Future<RepositoryResult<List<VehicleDatum>>> scanVin({
    required BuildContext context,
    required String vinNumber,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.scanVin,
      context: context,
      showLoading: showLoading,
      postParameters: {"vehicleNumber": vinNumber},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<List<VehicleDatum>> _parse(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(
          MappingException('Unexpected vehicle response structure'),
        );
      }

      final response = VehicleResponse.fromJson(json);
      if (response.code == 200 && response.success) {
        return Success(response.result.vehicleData);
      }

      return Failure(
        MappingException(
          response.message.isNotEmpty
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          errorCode: response.code.toString(),
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        UnknownException(
          S.of(context).anUnexpectedErrorOccuredPleaseTryAgain,
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}

class DemoVehicleRepository extends VehicleRepository {
  @override
  Future<RepositoryResult<List<VehicleDatum>>> scanVin({
    required BuildContext context,
    required String vinNumber,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success([
      VehicleDatum(
        category: 'General',
        values: [
          CategoryValue(key: 'Model Year', value: '2020'),
          CategoryValue(key: 'Make', value: 'Honda'),
          CategoryValue(key: 'Model', value: 'Civic'),
          CategoryValue(key: 'Vehicle Type', value: 'PASSENGER CAR'),
        ],
      ),
      VehicleDatum(
        category: 'Engine',
        values: [
          CategoryValue(key: 'Engine Number of Cylinders', value: '4'),
          CategoryValue(key: 'Displacement (L)', value: '2.0'),
        ],
      ),
    ]);
  }
}

VehicleRepository createVehicleRepository() {
  return AppConfig().isDemo ? DemoVehicleRepository() : ApiVehicleRepository();
}
