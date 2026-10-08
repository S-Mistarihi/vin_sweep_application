import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/scan_item_card.dart';

import '../../../../../../utils/ui/custom_loading_indicator.dart';

/// scans list with cases: load & error & empty & no found search & list found
class ScansListView extends StatelessWidget {
  const ScansListView({super.key, this.limit, this.bottomPadding = 24});

  final int? limit;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return Obx(() {
      final loading = c.isLoadingScans.value;
      final error = c.scansError.value;
      final total = c.scans.length;
      final searching = c.query.value.trim().isNotEmpty;
      final filtered = c.filteredScans;

      Widget content;
      if (loading && total == 0) {
        content = _scrollable([
          SizedBox(height: 8.h),
          CustomLoadingIndicator(isLoadMore: true),
        ]);
      } else if (error != null && total == 0) {
        content = _scrollable([
          SizedBox(height: 6.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors().errorText, fontSize: 16),
          ),
          TextButton(onPressed: c.loadScans, child: const Text('Retry')),
        ]);
      } else if (total == 0) {
        content = _scrollable([
          SizedBox(height: 2.h),
          SvgPicture.asset(AppAssets().emptyHomeScreen, height: 26.h),
          SizedBox(height: 2.h),
          _centerText('No Scans Yet', AppColors().mainColorWithNoScans, 20),
          const SizedBox(height: 8),
          _centerText(
            'The list is currently empty',
            AppColors().textFieldLabelColor,
            16,
          ),
        ]);
      } else if (filtered.isEmpty) {
        content = _scrollable([
          SizedBox(height: 8.h),
          _centerText('No results found', AppColors().textFieldLabelColor, 16),
        ]);
      } else {
        final items = (!searching && limit != null)
            ? filtered.take(limit!).toList()
            : filtered;

        content = ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24, 8, 24, bottomPadding),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (_, i) =>
              ScanItemCard(item: items[i], onTap: () => c.openScan(items[i])),
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
