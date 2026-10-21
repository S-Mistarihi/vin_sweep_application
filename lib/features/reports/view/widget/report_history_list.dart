import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/scan_history_response.dart';
import 'package:vin_sweep_application/features/reports/controller/reports_history_controller.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/features/reports/service/report_opener.dart';
import 'package:vin_sweep_application/features/reports/view/widget/report_history_tile.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/ui/shimmer_list_view.dart';

class ReportHistoryList extends StatelessWidget {
  const ReportHistoryList({super.key, this.limit, this.bottomPadding = 24});

  final int? limit;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ReportsHistoryController>();
    final home = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : null;

    return Obx(() {
      final loading = c.isLoading.value;
      final error = c.error.value;
      final total = c.reports.length;

      final names = <String, String>{
        for (final s in (home?.scans ?? const <ScanHistoryItem>[]))
          s.vin: s.title,
      };

      final groups = c.groups(names, limit: limit);

      Widget content;
      if (loading && total == 0) {
        content = ShimmerListView(
          size: 6,
          itemHeight: 80,
          radius: 23,
          spacing: 14,
          scrollable: true,
          padding: EdgeInsets.fromLTRB(24, 8, 24, bottomPadding),
        );
      } else if (error != null && total == 0) {
        content = _scrollable([
          SizedBox(height: 6.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors().errorText, fontSize: 16),
          ),
          TextButton(onPressed: c.load, child: const Text('Retry')),
        ]);
      } else if (total == 0) {
        content = _scrollable([
          SizedBox(height: 2.h),
          SvgPicture.asset(AppAssets().noReport, height: 22.h),
          SizedBox(height: 2.h),
          _centerText(S.of(context).noReportsYet, AppColors().accentColor, 20),
          const SizedBox(height: 8),
          _centerText(
            S.of(context).reportsYouBuyWillAppearHere,
            AppColors().textFieldLabelColor,
            15,
          ),
        ]);
      } else if (groups.isEmpty) {
        content = _scrollable([
          SizedBox(height: 8.h),
          _centerText(
            S.of(context).noResultsFound,
            AppColors().textFieldLabelColor,
            16,
          ),
        ]);
      } else {
        final rows = <Object>[];
        for (final g in groups) {
          rows.add(g.label);
          rows.addAll(g.items);
        }

        content = ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24, 8, 24, bottomPadding),
          itemCount: rows.length,
          itemBuilder: (_, i) {
            final row = rows[i];
            if (row is String) {
              return Padding(
                padding: EdgeInsets.only(top: i == 0 ? 0 : 16, bottom: 10),
                child: Text(
                  row,
                  style: TextStyle(
                    color: AppColors().textFieldLabelColor,
                    fontSize: 14,
                  ),
                ),
              );
            }

            final report = row as PdfReportDetails;
            final vin = report.vin ?? '';
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReportHistoryTile(
                title:
                    names[vin] ??
                    (vin.isEmpty ? S.of(context).vehicleReport : vin),
                vin: vin,
                onTap: () => ReportOpener.open(report),
              ),
            );
          },
        );
      }

      return RefreshIndicator(onRefresh: c.refreshAll, child: content);
    });
  }

  Widget _scrollable(List<Widget> children) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.fromLTRB(24, 0, 24, bottomPadding),
    children: children,
  );

  Widget _centerText(String text, Color color, double size) => Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
  );
}
