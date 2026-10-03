import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_model.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({super.key, required this.report, this.onTap});

  final PdfReportModel report;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final meta = [
      report.formattedDate,
      report.formattedSize,
    ].where((s) => s.isNotEmpty).join(' • ');

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors().cardPlanBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors().pdfBg,
                borderRadius: BorderRadius.circular(8),
              ),
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
                    report.fileName ?? 'Vehicle Report',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (meta.isNotEmpty)
                    Text(
                      meta,
                      style: TextStyle(
                        color: AppColors().textFieldLabelColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.download_rounded,
              color: AppColors().buttonWithBackground,
            ),
          ],
        ),
      ),
    );
  }
}
