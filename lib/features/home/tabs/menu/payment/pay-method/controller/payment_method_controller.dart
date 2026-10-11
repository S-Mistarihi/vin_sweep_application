import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/repository/payment_method_repository.dart'; // عدّل المسار حسب مشروعك
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../../../utils/ui/custom_snakbar.dart';
import '../model/payment_method_response.dart';

class PaymentMethodController extends GetxController {
  final methods = <PayMethod>[].obs;
  final isLoading = false.obs;
  final RxBool forceRefresh = false.obs;
  final errorMessage = RxnString();

  @override
  void onReady() {
    super.onReady();
    loadMethods();
  }

  Future<void> loadMethods() async {
    final context = Get.context!;

    isLoading.value = true;
    errorMessage.value = null;

    final result = await createPaymentMethodRepository().getPaymentMethod(
      context: context,
      forceRefresh: forceRefresh.value,
    );
    switch (result) {
      case Success(:final data):
        methods.assignAll(data);
      case Failure(:final exception):
        errorMessage.value = exception.message;
    }

    isLoading.value = false;
  }

  Future<void> setDefault(PayMethod method) async {
    if (method.resultDefault) return;
    final context = Get.context!;

    final result = await createPaymentMethodRepository()
        .setDefaultPaymentMethod(
          context: context,
          paymentMethodId: method.paymentMethodId,
        );

    switch (result) {
      case Success():
        await loadMethods();
      case Failure(:final exception):
        _showError(exception.message);
    }
  }

  Future<void> deleteMethod(PayMethod method) async {
    final context = Get.context!;

    final result = await createPaymentMethodRepository().deletePaymentMethod(
      context: context,
      paymentMethodId: method.paymentMethodId,
    );

    switch (result) {
      case Success():
        await loadMethods();
      case Failure(:final exception):
        _showError(exception.message);
    }
  }

  void _showError([String? message]) {
    CustomSnakbar.error(
      'Error',
      message,
      fallback: 'Failed set/delete payment method',
    );
  }
}
