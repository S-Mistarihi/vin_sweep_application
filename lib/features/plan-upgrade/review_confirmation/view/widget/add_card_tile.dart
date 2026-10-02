import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

import '../../../../../generated/l10n.dart';

class AddCardTile extends StatelessWidget {
  const AddCardTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors().cardPlanBorder, width: 2),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets().addPayCard),
            const SizedBox(width: 18),
            Text(
              S.of(context).addCardButton,
              style: TextStyle(
                color: AppColors().accentColor,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
