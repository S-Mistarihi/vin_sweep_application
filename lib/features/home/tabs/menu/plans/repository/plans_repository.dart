import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

abstract class PlansRepository {
  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiPlansRepository extends PlansRepository {
  @override
  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPlans,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<PlansResponse> _parse(String body, BuildContext context) {
    try {
      if (body.trim().isEmpty) {
        return Failure(
          ParsingException(S.of(context).theServerReturnedAnInvalidFormat),
        );
      }
      debugPrint('========== PLANS API RESPONSE ==========');
      debugPrint(body);
      debugPrint('=========================================');
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected plan response structure'));
      }
      final response = PlansResponse.fromJson(json);
      if (response.success == true && response.plans != null) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('========== PLANS PARSING ERROR ==========');
      debugPrint('ERROR: $error');
      debugPrint('STACK TRACE: $stackTrace');
      debugPrint('==========================================');
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

class DemoPlansRepository extends PlansRepository {
  @override
  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Success(
      PlansResponse(
        success: true,
        code: 200,
        message: 'Get Plans Successfully',
        plans: [
          PlanModel(
            id: 1,
            name: 'Plan 1',
            title: 'Free Version',
            price: 8,
            reportPrice: 5,
            validityDays: 30,
            mostPopular: true,
            active: true,
          ),
        ],
      ),
    );
  }
}

PlansRepository createPlansRepository() {
  return AppConfig().isDemo ? DemoPlansRepository() : ApiPlansRepository();
}
