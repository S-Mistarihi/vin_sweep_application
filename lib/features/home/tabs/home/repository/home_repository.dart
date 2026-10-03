import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../menu/plans/model/plans_response.dart';
import '../../menu/plans/model/user_plan_response.dart';
import '../model/scan_history_response.dart';

abstract class HomeRepository {
  Future<RepositoryResult<List<ScanHistoryItem>>> getScanHistory({
    required BuildContext context,
    bool showLoading = false,
  });

  Future<RepositoryResult<List<UserPlanResponse>>> getPlanHistory({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiHomeRepository extends HomeRepository {
  //
  @override
  Future<RepositoryResult<List<ScanHistoryItem>>> getScanHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getUserSearchHistory,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseScanHistory(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<List<UserPlanResponse>>> getPlanHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getUserPlanHistory,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parsePlanHistory(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<List<ScanHistoryItem>> _parseScanHistory(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      if (json['success'] == true) {
        final response = (json['result'] as List? ?? [])
            .map((e) => ScanHistoryItem.fromJson(e as Map<String, dynamic>))
            .toList();
        return Success(response);
      }

      final message = (json['message'] ?? '').toString();
      return Failure(
        MappingException(
          message.isNotEmpty
              ? message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          errorCode: (json['code'] ?? '').toString(),
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

  RepositoryResult<List<UserPlanResponse>> _parsePlanHistory(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      if (json['success'] == true) {
        final response = (json['result'] as List? ?? [])
            .map((e) => UserPlanResponse.fromJson(e as Map<String, dynamic>))
            .toList();
        return Success(response);
      }

      final message = (json['message'] ?? '').toString();
      return Failure(
        MappingException(
          message.isNotEmpty
              ? message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          errorCode: (json['code'] ?? '').toString(),
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

class DemoHomeRepository extends HomeRepository {
  @override
  Future<RepositoryResult<List<ScanHistoryItem>>> getScanHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success([
      ScanHistoryItem(
        vehicleNumber: '5B2QW9022A3911911',
        vehicleMake: 'Mercedes',
        vehicleModel: 'C-Class',
        vehicleModelYear: '2022',
        searchTime: DateTime.now().subtract(const Duration(days: 1)),
        pdfReportsCount: 1,
      ),
      ScanHistoryItem(
        vehicleNumber: '4Y1SL65848Z411439',
        vehicleMake: 'Toyota',
        vehicleModel: 'Camry',
        vehicleModelYear: '2025',
        searchTime: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ScanHistoryItem(
        vehicleNumber: '5B2QW9022A3911912',
        vehicleMake: 'Porsche',
        vehicleModel: '911',
        vehicleModelYear: '2008',
        searchTime: DateTime.now().subtract(const Duration(days: 3)),
        pdfReportsCount: 2,
      ),
    ]);
  }

  @override
  Future<RepositoryResult<List<UserPlanResponse>>> getPlanHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success([
      UserPlanResponse(
        id: 2,
        userId: 1,
        plan: PlanModel(id: 2, name: 'Package', reportsCount: 3),
        reportsRemaining: 3,
        status: 'ON_HOLD',
      ),
    ]);
  }
}

HomeRepository createHomeRepository() {
  return AppConfig().isDemo ? DemoHomeRepository() : ApiHomeRepository();
}
