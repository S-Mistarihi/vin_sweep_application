import 'package:get/get.dart';

enum SearchMode { info, report }

class SearchingModeController extends GetxController {
  final Rx<SearchMode> searchMode = SearchMode.info.obs;

  bool get isInfo => searchMode.value == SearchMode.info;

  bool get isReport => searchMode.value == SearchMode.report;

  void switchSearchMode(SearchMode mode) {
    if (searchMode.value == mode) return;

    searchMode.value = mode;
  }

  void switchToInfo() {
    switchSearchMode(SearchMode.info);
  }

  void switchToReport() {
    switchSearchMode(SearchMode.report);
  }
}
