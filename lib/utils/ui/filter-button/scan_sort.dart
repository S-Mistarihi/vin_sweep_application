enum ScanSort {
  newest,
  oldest,
  makeAZ,
  yearNewest;

  String get label => switch (this) {
    ScanSort.newest => 'Newest first',
    ScanSort.oldest => 'Oldest first',
    ScanSort.makeAZ => 'Make (A–Z)',
    ScanSort.yearNewest => 'Model year (newest)',
  };
}
