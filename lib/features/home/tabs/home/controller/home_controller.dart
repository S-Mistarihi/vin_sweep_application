import 'package:get/get.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/searching_view.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/scan_history_response.dart';
import 'package:vin_sweep_application/features/home/tabs/home/repository/home_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/repository/plans_repository.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

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
    if (q.isEmpty) return scans.toList();
    return scans
        .where(
          (s) =>
      s.title.toLowerCase().contains(q) ||
          s.vin.toLowerCase().contains(q),
    )
        .toList();
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

  void openPlans() => PlansNavigator.openMyPlans();

  void openScan(ScanHistoryItem item) {
    if (item.vin.isEmpty) return;
    Get.to(() => SearchingView(vinNumber: item.vin));
  }
}