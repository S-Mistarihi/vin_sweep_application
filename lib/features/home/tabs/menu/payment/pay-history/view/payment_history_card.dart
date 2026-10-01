import 'package:flutter/cupertino.dart';

import '../../../../../../../configuration/app_colors.dart';
import '../model/payment_history_response.dart';

class PaymentHistoryCard extends StatelessWidget {
  final PayHistory payment;

  const PaymentHistoryCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: AppColors().switcherBackgroundColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors().accentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  payment.formattedDate,
                  style: TextStyle(
                    color: AppColors().textFieldLabelColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            payment.formattedAmount,
            style: TextStyle(
              color: AppColors().accentColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
