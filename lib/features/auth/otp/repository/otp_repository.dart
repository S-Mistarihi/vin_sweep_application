import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';

import '../../../../configuration/app_config.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../../utils/helpers/common/repository_result.dart';
import '../../../../utils/helpers/http/http_wrapper.dart';
import '../../register/model/generic_response.dart';
import '../model/verify_otp_response.dart';

abstract class OtpRepository {
  //endPoint prototype
  Future<RepositoryResult<GenericResponse>> generateOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    bool showLoading = true,
  });

  Future<RepositoryResult<VerifyOtpResponse>> verifyOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    required String otpCode,
    bool showLoading = true,
  });
}

class ApiOtpRepository extends OtpRepository {
  //Method 1
  //***************************************************************************
  @override
  Future<RepositoryResult<GenericResponse>> generateOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.generateOtp,
      context: context,
      showLoading: showLoading,
      postParameters: {'email': email, 'otpType': type.apiValue},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseGeneric(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<GenericResponse> _parseGeneric(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(MappingException('Unexpected OTP response'));
      }
      final response = GenericResponse.fromJson(json);
      if (response.code == 200 && response.success) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty
              ? response.message
              : S.current.theServerReturnedAnUnsuccessfulResponse,
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

  //Method 2
  //***************************************************************************
  @override
  Future<RepositoryResult<VerifyOtpResponse>> verifyOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    required String otpCode,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.verifyOtp,
      context: context,
      showLoading: showLoading,
      postParameters: {
        'email': email,
        'otpType': type.apiValue,
        'otpCode': otpCode,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseVerify(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<VerifyOtpResponse> _parseVerify(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(
          MappingException('Unexpected verify OTP response'),
        );
      }
      final response = VerifyOtpResponse.fromJson(json);
      if (response.code == 200 && response.success == true) {
        return Success(response);
      }
      return Failure(
        MappingException(
          (response.message?.isNotEmpty == true)
              ? response.message!
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          errorCode: response.code?.toString(),
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

class DemoOtpRepository extends OtpRepository {
  @override
  Future<RepositoryResult<GenericResponse>> generateOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(
      GenericResponse(success: true, code: 200, message: 'OTP sent'),
    );
  }

  @override
  Future<RepositoryResult<VerifyOtpResponse>> verifyOtp({
    required BuildContext context,
    required String email,
    required OtpType type,
    required String otpCode,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success(
      VerifyOtpResponse(
        success: true,
        code: 200,
        message: 'Verified',
        result: VerifyOtpToken(token: 'demo-otp-token'),
      ),
    );
  }
}

OtpRepository createOtpRepository() {
  return AppConfig().isDemo ? DemoOtpRepository() : ApiOtpRepository();
}
