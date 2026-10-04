import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/plan-upgrade/add_card/model/saved_card_model.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.card,
    required this.selected,
    required this.onTap,
  });

  final SavedCardModel card;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors().switcherBackgroundColor),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets().payCard),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                card.masked,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors().accentColor : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? AppColors().accentColor
                      : AppColors().switcherBackgroundColor,
                  width: 2,
                ),
              ),
              child: selected
                  ? Icon(Icons.check, size: 14, color: AppColors().baseColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
