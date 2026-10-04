import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/coupon/repository/coupon_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../model/coupon_response.dart';

class CouponController extends GetxController {
  final TextEditingController couponText = TextEditingController();

  final Rxn<CouponResult> coupon = Rxn<CouponResult>();
  final RxBool isApplyingCoupon = false.obs;
  final RxnString couponError = RxnString();

  @override
  void onClose() {
    couponText.dispose();
    super.onClose();
  }

  Future<void> applyCoupon() async {
    final code = couponText.text.trim();

    if (code.isEmpty || isApplyingCoupon.value) return;

    FocusManager.instance.primaryFocus?.unfocus();

    isApplyingCoupon.value = true;
    couponError.value = null;

    final result = await createCouponRepository().validateCoupon(
      context: Get.context!,
      couponCode: code,
    );

    isApplyingCoupon.value = false;

    switch (result) {
      case Failure(:final exception):
        coupon.value = null;
        couponError.value = exception.message;

      case Success(:final data):
        if (data.applied) {
          coupon.value = data;
        } else {
          coupon.value = null;
          couponError.value = data.message.isNotEmpty
              ? data.message
              : 'Invalid coupon code';
        }
    }
  }

  void removeCoupon() {
    coupon.value = null;
    couponError.value = null;
    couponText.clear();
  }

  bool get hasCoupon => coupon.value?.applied ?? false;

  String? get couponCode {
    if (!hasCoupon) return null;
    return coupon.value!.couponCode;
  }

  double? get finalAmount => coupon.value?.finalAmount;
}