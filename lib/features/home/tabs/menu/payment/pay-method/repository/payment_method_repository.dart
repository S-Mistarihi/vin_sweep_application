import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../../../../auth/register/model/generic_response.dart';
import '../model/payment_method_response.dart';

abstract class PaymentMethodRepository {
  Future<RepositoryResult<List<PayMethod>>> getPaymentMethod({
    required BuildContext context,
    required bool forceRefresh,
    bool showLoading = false,
  });

  Future<RepositoryResult<GenericResponse>> setDefaultPaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = true,
  });

  Future<RepositoryResult<GenericResponse>> deletePaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = false,
  });
}

class ApiPaymentMethodRepository extends PaymentMethodRepository {
  //
  @override
  Future<RepositoryResult<List<PayMethod>>> getPaymentMethod({
    required BuildContext context,
    required bool forceRefresh,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPaymentMethod(forceRefresh),
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parsePayMethod(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<GenericResponse>> setDefaultPaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.setDefaultPaymentMethod,
      context: context,
      showLoading: showLoading,
      postParameters: {"paymentMethodId": paymentMethodId},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseAction(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<GenericResponse>> deletePaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.deletePaymentMethod,
      context: context,
      showLoading: showLoading,
      postParameters: {"paymentMethodId": paymentMethodId},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseAction(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<List<PayMethod>> _parsePayMethod(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(
          MappingException('Unexpected payment method response structure'),
        );
      }

      final response = PaymentMethodResponse.fromJson(json);
      if (response.success) {
        return Success(response.result);
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

  RepositoryResult<GenericResponse> _parseAction(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(MappingException('Unexpected response structure'));
      }

      final response = GenericResponse.fromJson(json);
      if (response.success) {
        return Success(response);
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

class DemoPaymentMethodRepository extends PaymentMethodRepository {
  @override
  Future<RepositoryResult<List<PayMethod>>> getPaymentMethod({
    required BuildContext context,
    required bool forceRefresh,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success([
      PayMethod(
        paymentMethodId: '1',
        type: 'type',
        displayName: 'Alex Jhon',
        metadata: '123456789123456',
        expired: false,
        resultDefault: true,
      ),
      PayMethod(
        paymentMethodId: '2',
        type: 'type',
        displayName: 'Alaa Ahmad',
        metadata: '123456732129876',
        expired: false,
        resultDefault: false,
      ),
    ]);
  }

  @override
  Future<RepositoryResult<GenericResponse>> setDefaultPaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(
      GenericResponse(
        success: true,
        message: 'Sucessfully set the defualt',
        code: 200,
      ),
    );
  }

  @override
  Future<RepositoryResult<GenericResponse>> deletePaymentMethod({
    required BuildContext context,
    required String paymentMethodId,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(
      GenericResponse(
        success: true,
        message: 'Sucessfully deleted the method',
        code: 200,
      ),
    );
  }
}

PaymentMethodRepository createPaymentMethodRepository() {
  return AppConfig().isDemo
      ? DemoPaymentMethodRepository()
      : ApiPaymentMethodRepository();
}
