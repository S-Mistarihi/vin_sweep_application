import 'package:get/get.dart';

enum AddCardMode {
  ///setup-intent → add card only from (Payments Info screen)
  setup,

  ///create-payment-intent → paying subscription using new card via (Review screen)
  subscribe,
}

class AddCartController extends GetxController {}
