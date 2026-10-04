import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class ReportHistoryTile extends StatelessWidget {
  const ReportHistoryTile({
    super.key,
    required this.title,
    required this.vin,
    required this.onTap,
  });

  final String title;
  final String vin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors().cardPlanBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors().cardPlanShadow.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xff6A8CAF),
                borderRadius: BorderRadius.circular(10),
              ),
              // TODO: أيقونة PDF من التصميم
              child: Transform.scale(
                scale: .6,
                child: SvgPicture.asset(AppAssets().pdfIcon),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vin,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().cardPlanText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
