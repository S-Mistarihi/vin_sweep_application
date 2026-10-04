import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/switcher/reports/view/report_tile.dart';

import '../../../../../../../configuration/app_assets.dart';
import '../../../../../../../configuration/app_colors.dart';
import '../../../../../../reports/service/report_opener.dart';
import '../../../../controller/vehicle_reports_controller.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key, required this.controller});

  final VehicleReportsController controller;

  @override
  Widget build(BuildContext context) {
    final reports = controller.reports.toList();
    if (reports.isEmpty) return _contentWithNoReportBuy();

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors().generalInfoContainerBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors().generalInfoContainerBorder,
              width: 2,
            ),
          ),
          child: Text(
            'Bought reports include accident history, mileage records, previous ownership, and more.',
            style: TextStyle(color: AppColors().accentColor, fontSize: 15),
          ),
        ),

        ...reports.map(
          (r) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ReportTile(report: r, onTap: () => ReportOpener.open(r)),
          ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }

  Widget _contentWithNoReportBuy() {
    return Column(
      children: [
        SizedBox(height: 12.h),
        SvgPicture.asset(AppAssets().noReport),
        const SizedBox(height: 40),
        Text(
          'No reports yet for this vehicle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors().accentColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Reports include accident history, mileage verification, previous owners, and more.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: AppColors().subIntroText),
        ),
      ],
    );
  }
}
