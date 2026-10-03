class ScanHistoryItem {
  final String vehicleNumber;
  final String vehicleMake;
  final String vehicleModel;
  final String vehicleModelYear;
  final DateTime? searchTime;
  final int pdfReportsCount;

  const ScanHistoryItem({
    required this.vehicleNumber,
    this.vehicleMake = '',
    this.vehicleModel = '',
    this.vehicleModelYear = '',
    this.searchTime,
    this.pdfReportsCount = 0,
  });

  factory ScanHistoryItem.fromJson(Map<String, dynamic> json) =>
      ScanHistoryItem(
        vehicleNumber: (json['vehicleNumber'] ?? '').toString(),
        vehicleMake: (json['vehicleMake'] ?? '').toString(),
        vehicleModel: (json['vehicleModel'] ?? '').toString(),
        vehicleModelYear: (json['vehicleModelYear'] ?? '').toString(),
        searchTime: json['searchTime'] == null
            ? null
            : DateTime.tryParse(json['searchTime'].toString()),
        pdfReportsCount: (json['pdfReportsCount'] as num?)?.toInt() ?? 0,
      );

  String get vin => vehicleNumber;

  /// Mercedes C-Class - 2022
  String get title {
    final name = '$vehicleMake $vehicleModel'.trim();
    if (name.isEmpty && vehicleModelYear.isEmpty) return 'Unknown vehicle';
    if (vehicleModelYear.isEmpty) return name;
    if (name.isEmpty) return vehicleModelYear;
    return '$name - $vehicleModelYear';
  }

  bool get hasReports => pdfReportsCount > 0;

  /// "1 Report" / "2 Reports"
  String get reportsLabel =>
      pdfReportsCount == 1 ? '1 Report' : '$pdfReportsCount Reports';
}
