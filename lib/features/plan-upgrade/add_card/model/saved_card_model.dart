import '../../../home/tabs/menu/payment/pay-method/model/payment_method_response.dart';

class SavedCardModel {
  final String id; // Stripe paymentMethodId (pm_xxx)
  final String brand;
  final String last4;

  ///true = saved at backend & false = new card awaiting payment
  final bool isSaved;

  ///user want to save card after payment
  final bool saveForFuture;

  const SavedCardModel({
    required this.id,
    required this.brand,
    required this.last4,
    this.isSaved = true,
    this.saveForFuture = false,
  });

  String get masked => '**** **** **** $last4';
}

extension PayMethodToSavedCard on PayMethod {
  SavedCardModel toSavedCard() => SavedCardModel(
    id: paymentMethodId,
    brand: type,
    last4: maskedNumber.replaceAll(RegExp(r'\D'), ''),
    isSaved: true,
  );
}
