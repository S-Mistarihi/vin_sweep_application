import 'package:get/get.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/searching_view.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/scan_history_response.dart';
import 'package:vin_sweep_application/features/home/tabs/home/repository/home_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../../../utils/ui/filter-button/date_period.dart';
import '../../../../../utils/ui/filter-button/filter_dialog.dart';
import '../../../../../utils/ui/filter-button/scan_sort.dart';

class HomeController extends GetxController {
  // ───────── Plan ─────────
  final Rxn<UserPlanResponse> subscription = Rxn<UserPlanResponse>();
  final RxList<UserPlanResponse> onHoldPackages = <UserPlanResponse>[].obs;
  final RxBool isLoadingPlan = false.obs;
  final RxnString planError = RxnString();

  // ───────── Recent Searches ─────────
  final RxList<ScanHistoryItem> scans = <ScanHistoryItem>[].obs;
  final RxBool isLoadingScans = false.obs;
  final RxnString scansError = RxnString();
  final RxString query = ''.obs;

  final RxBool withReportsOnly = false.obs;

  final Rx<ScanSort> scanSort = ScanSort.newest.obs;
  final Rx<DatePeriod> scanPeriod = DatePeriod.all.obs;

  bool get hasActiveFilter =>
      scanSort.value != ScanSort.newest || scanPeriod.value != DatePeriod.all;

  static const int latestCount = 5;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  PlanCardInfo get planInfo => PlanCardInfo.from(subscription.value);

  /// package reports (on hold) --> (PremiumScreen)
  int get onHoldReports =>
      onHoldPackages.fold<int>(0, (s, e) => s + (e.reportsRemaining ?? 0));

  /// number of element (search-history) // source of TotalSweep unknown
  int get totalSweeps => scans.length;

  List<ScanHistoryItem> get filteredScans {
    final q = query.value.trim().toLowerCase();
    final onlyWithReports = withReportsOnly.value;
    final cutoff = scanPeriod.value.cutoff(DateTime.now());

    final list = scans.where((s) {
      if (onlyWithReports && !s.hasReports) return false;
      if (cutoff != null) {
        final t = s.searchTime?.toLocal();
        if (t == null || t.isBefore(cutoff)) return false;
      }
      if (q.isEmpty) return true;
      return s.title.toLowerCase().contains(q) ||
          s.vin.toLowerCase().contains(q);
    }).toList();

    switch (scanSort.value) {
      case ScanSort.newest:
        break;
      case ScanSort.oldest:
        list.sort(
              (a, b) => (a.searchTime ?? DateTime(0)).compareTo(
            b.searchTime ?? DateTime(0),
          ),
        );
      case ScanSort.makeAZ:
        list.sort((a, b) {
          final c = a.vehicleMake.toLowerCase().compareTo(
            b.vehicleMake.toLowerCase(),
          );
          return c != 0
              ? c
              : a.vehicleModel.toLowerCase().compareTo(
            b.vehicleModel.toLowerCase(),
          );
        });
      case ScanSort.yearNewest:
        list.sort(
              (a, b) => (int.tryParse(b.vehicleModelYear) ?? 0).compareTo(
            int.tryParse(a.vehicleModelYear) ?? 0,
          ),
        );
    }
    return list;
  }

  Future<void> refreshAll() => Future.wait([loadPlan(), loadScans()]);

  Future<void> loadPlan() async {
    isLoadingPlan.value = true;
    planError.value = null;

    final result = await createPlansRepository().getCurrentUserPlan(
      context: Get.context!,
    );
    switch (result) {
      case Failure(:final exception):
        planError.value = exception.message;
      case Success(:final data):
        subscription.value = data;
    }

    // Premium only
    if (planError.value == null &&
        planInfo.variant == HomePlanVariant.premium) {
      await _loadOnHold();
    } else {
      onHoldPackages.clear();
    }

    isLoadingPlan.value = false;
  }

  Future<void> _loadOnHold() async {
    final result = await createHomeRepository().getPlanHistory(
      context: Get.context!,
    );
    switch (result) {
      case Failure():
        onHoldPackages.clear();
      case Success(:final data):
        onHoldPackages.assignAll(
          data.where((s) => s.status?.toUpperCase().contains('HOLD') == true),
        );
    }
  }

  Future<void> loadScans() async {
    isLoadingScans.value = true;
    scansError.value = null;

    final result = await createHomeRepository().getScanHistory(
      context: Get.context!,
    );
    switch (result) {
      case Failure(:final exception):
        scansError.value = exception.message;
      case Success(:final data):
      // newest first
        final sorted = [...data]
          ..sort(
                (a, b) => (b.searchTime ?? DateTime(0)).compareTo(
              a.searchTime ?? DateTime(0),
            ),
          );
        scans.assignAll(sorted);
    }

    isLoadingScans.value = false;
  }

  void clearSearch() => query.value = '';

  void resetFilters() {
    clearSearch();
    withReportsOnly.value = false;
  }

  Future<void> openFilter() async {
    final r = await FilterDialog.show(
      title: 'Filter', // TODO: l10n
      groups: [
        FilterGroupSpec(
          'Sort by',
          ScanSort.values.map((e) => e.label).toList(),
          scanSort.value.index,
        ),
        FilterGroupSpec(
          'Period',
          DatePeriod.values.map((e) => e.label).toList(),
          scanPeriod.value.index,
        ),
      ],
    );
    if (r == null) return;
    scanSort.value = ScanSort.values[r[0]];
    scanPeriod.value = DatePeriod.values[r[1]];
  }

  void openPlans() => PlansNavigator.openMyPlans();

  void openScan(ScanHistoryItem item) {
    if (item.vin.isEmpty) return;
    Get.to(() => SearchingView(vinNumber: item.vin));
  }
}