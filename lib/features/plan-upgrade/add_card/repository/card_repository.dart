import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/auth/register/model/generic_response.dart';

import '../../../../configuration/api_end_points.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../../utils/helpers/http/http_wrapper.dart';
import '../model/payment_intent_response.dart';

abstract class CardRepository {
  Future<RepositoryResult<SetupIntentData>> createSetupIntent({
    required BuildContext context,
    bool showLoading = false,
  });

  Future<RepositoryResult<GenericResponse>> confirmSetupIntent({
    required BuildContext context,
    required String setupIntentId,
    bool showLoading = false,
  });
}

class ApiCardRepository extends CardRepository {
  //
  @override
  Future<RepositoryResult<SetupIntentData>> createSetupIntent({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.setupIntent,
      context: context,
      showLoading: showLoading,
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseSetup(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<GenericResponse>> confirmSetupIntent({
    required BuildContext context,
    required String setupIntentId,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.confirmSetupIntent,
      context: context,
      showLoading: false,
      postParameters: {"setupIntentId": setupIntentId},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseConfirmSetup(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<SetupIntentData> _parseSetup(
    String body,
    BuildContext context,
  ) {
    try {
      if (body.trim().isEmpty) {
        return Failure(
          ParsingException(S.of(context).theServerReturnedAnInvalidFormat),
        );
      }
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected setup response structure'));
      }

      final response = PaymentIntentResponse.fromJson(json);
      if (response.success && response.result.clientSecret.isNotEmpty) {
        return Success(response.result);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty == true
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
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

  RepositoryResult<GenericResponse> _parseConfirmSetup(
    String body,
    BuildContext context,
  ) {
    try {
      if (body.trim().isEmpty) {
        return Failure(
          ParsingException(S.of(context).theServerReturnedAnInvalidFormat),
        );
      }
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }
      final response = GenericResponse.fromJson(json);
      if (response.success) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty == true
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
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

class DemoCardRepository extends CardRepository {
  @override
  Future<RepositoryResult<SetupIntentData>> createSetupIntent({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      SetupIntentData(
        setupIntentId: 'seti_demo',
        clientSecret: 'seti_demo_secret',
      ),
    );
  }

  @override
  Future<RepositoryResult<GenericResponse>> confirmSetupIntent({
    required BuildContext context,
    required String setupIntentId,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      GenericResponse(
        success: true,
        code: 200,
        message: 'Successfully confirm setup intent',
      ),
    );
  }
}

CardRepository createCardRepository() {
  return AppConfig().isDemo ? DemoCardRepository() : ApiCardRepository();
}
