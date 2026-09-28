import 'package:get/get.dart';

enum PaymentMode { payMethod, payHistory }

class PaymentController extends GetxController{
  final Rx<PaymentMode> payMode = PaymentMode.payMethod.obs;

  bool get isPayMethod => payMode.value == PaymentMode.payMethod;

  bool get isPayHistory => payMode.value == PaymentMode.payHistory;

  void switchSearchMode(PaymentMode mode) {
    if (payMode.value == mode) return;

    payMode.value = mode;
  }

  void switchToMethod() {
    switchSearchMode(PaymentMode.payMethod);
  }

  void switchToHistory() {
    switchSearchMode(PaymentMode.payHistory);
  }

}