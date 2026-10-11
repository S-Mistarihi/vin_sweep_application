import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/about/model/about_us_response.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

abstract class AboutUsRepository {
  Future<RepositoryResult<AboutUsResponse>> getAboutUs({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiAboutUsRepository extends AboutUsRepository {
  @override
  Future<RepositoryResult<AboutUsResponse>> getAboutUs({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.aboutUs,
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

  RepositoryResult<AboutUsResponse> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected About Us response'));
      }

      final response = AboutUsResponse.fromJson(json);
      if (response.success == true &&
          (response.result?.trim().isNotEmpty ?? false)) {
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

class DemoAboutUsRepository extends AboutUsRepository {
  @override
  Future<RepositoryResult<AboutUsResponse>> getAboutUs({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(
      AboutUsResponse(
        success: true,
        code: 200,
        message: 'AboutUs Description Text!',
        result:
        'VINSweep is a cutting-edge mobile app specializing in the search of vehicle information and history through advanced VIN recognition technology.\n\n'
            'Our solution provides users with instant access to comprehensive information for any vehicle.\n\n'
            'We are committed to delivering reliable and secure services. If you have any questions or comments, please reach out to us.',
      ),
    );
  }
}

AboutUsRepository createAboutUsRepository() {
  return AppConfig().isDemo ? DemoAboutUsRepository() : ApiAboutUsRepository();
}