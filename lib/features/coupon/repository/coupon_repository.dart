import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';

import '../../../configuration/api_end_points.dart';
import '../../../generated/l10n.dart';
import '../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../utils/helpers/common/repository_result.dart';
import '../../../utils/helpers/http/http_wrapper.dart';
import '../model/coupon_response.dart';

abstract class CouponRepository {
  Future<RepositoryResult<CouponResult>> validateCoupon({
    required BuildContext context,
    required String couponCode,
    bool showLoading = false,
  });
}

class ApiCouponRepository extends CouponRepository {
  @override
  Future<RepositoryResult<CouponResult>> validateCoupon({
    required BuildContext context,
    required String couponCode,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.validateCoupon,
      context: context,
      showLoading: showLoading,
      postParameters: {"couponCode": couponCode},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<CouponResult> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = CouponResponse.fromJson(json);
      if (response.success == true) {
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
}

class DemoCouponRepository extends CouponRepository {
  @override
  Future<RepositoryResult<CouponResult>> validateCoupon({
    required BuildContext context,
    required String couponCode,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      CouponResult(
        couponCode: couponCode,
        originalAmount: 10,
        discountAmount: 0,
        finalAmount: 10,
        discountPercentage: 0,
        applied: false,
        message: 'Invalid coupon code',
      ),
    );
  }
}

CouponRepository createCouponRepository() {
  return AppConfig().isDemo ? DemoCouponRepository() : ApiCouponRepository();
}
