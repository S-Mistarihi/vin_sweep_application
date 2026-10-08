import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/repository/payment_method_repository.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/controller/add_card_controller.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/view/add_card_view.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../utils/ui/custom_snakbar.dart';

mixin CardSelectionMixin on GetxController {
  final RxList<SavedCardModel> cards = <SavedCardModel>[].obs;
  final RxnString selectedCardId = RxnString();
  final RxBool isLoadingCards = false.obs;
  final RxBool forceRefresh = false.obs;

  SavedCardModel? get selectedCard =>
      cards.firstWhereOrNull((c) => c.id == selectedCardId.value);

  Future<void> loadCards() async {
    isLoadingCards.value = true;

    final result = await createPaymentMethodRepository().getPaymentMethod(
      context: Get.context!,
      forceRefresh: forceRefresh.value,
    );

    switch (result) {
      case Failure(:final exception):
        showAppSnackbar('Failed', exception.message, isError: true);
      case Success(:final data):
        final usable = data.where((m) => !m.expired).toList();
        cards.assignAll(usable.map((m) => m.toSavedCard()));
        final preferred =
            usable.firstWhereOrNull((m) => m.resultDefault) ??
            usable.firstOrNull;
        selectedCardId.value = preferred?.paymentMethodId;
    }

    isLoadingCards.value = false;
  }

  void selectCard(SavedCardModel card) => selectedCardId.value = card.id;

  Future<void> addCard() async {
    final card = await Get.to<SavedCardModel>(
      () => const AddCardView(mode: AddCardMode.subscribe),
    );
    if (card == null) return;
    cards.insert(0, card);
    selectedCardId.value = card.id;
  }

  void showAppSnackbar(String title, String? message, {bool isError = false}) {
    CustomSnakbar.show(title, message, isError: isError);
  }
}
