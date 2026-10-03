import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../../../../generated/l10n.dart';
import '../model/payment_history_response.dart';

abstract class PaymentHistoryRepository {
  Future<RepositoryResult<List<PayHistory>>> getPaymentHistory({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiPaymentHistoryRepository extends PaymentHistoryRepository {
  @override
  Future<RepositoryResult<List<PayHistory>>> getPaymentHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPaymentHistory,
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

  RepositoryResult<List<PayHistory>> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(
          MappingException('Unexpected payment history response structure'),
        );
      }

      final response = PaymentHistoryResponse.fromJson(json);
      if (response.success == true) {
        return Success(response.result ?? []);
      }

      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
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

class DemoPaymentHistoryRepository extends PaymentHistoryRepository {
  @override
  Future<RepositoryResult<List<PayHistory>>> getPaymentHistory({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success([
      PayHistory(
        id: 1,
        description: 'Plan subscription',
        amount: 25,
        currency: 'usd',
        createdAt: DateTime(2025, 8, 10),
      ),
      PayHistory(
        id: 2,
        description: 'Report Purchase',
        amount: 10,
        currency: 'usd',
        createdAt: DateTime(2025, 8, 8),
      ),
    ]);
  }
}

PaymentHistoryRepository createPaymentHistoryRepository() {
  return AppConfig().isDemo
      ? DemoPaymentHistoryRepository()
      : ApiPaymentHistoryRepository();
}
