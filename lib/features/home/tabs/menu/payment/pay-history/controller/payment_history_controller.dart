import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-history/model/payment_history_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-history/repository/payment_history_repository.dart'; // عدّل المسار حسب مشروعك
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

class PaymentHistoryController extends GetxController {
  final history = <PayHistory>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  @override
  void onReady() {
    super.onReady();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final context = Get.context;
    if (context == null) return;

    isLoading.value = true;
    errorMessage.value = null;

    final result = await createPaymentHistoryRepository().getPaymentHistory(
      context: context,
    );

    switch (result) {
      case Success(:final data):
        // newest first
        final sorted = [...data]
          ..sort(
            (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
              a.createdAt ?? DateTime(0),
            ),
          );
        history.assignAll(sorted);
      case Failure(:final exception):
        errorMessage.value = exception.toString();
    }

    isLoading.value = false;
  }
}
