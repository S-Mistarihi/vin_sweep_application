enum DatePeriod {
  all,
  last7,
  last30,
  last90;

  String get label => switch (this) {
    DatePeriod.all => 'All time',
    DatePeriod.last7 => 'Last 7 days',
    DatePeriod.last30 => 'Last 30 days',
    DatePeriod.last90 => 'Last 90 days',
  };

  DateTime? cutoff(DateTime now) => switch (this) {
    DatePeriod.all => null,
    DatePeriod.last7 => now.subtract(const Duration(days: 7)),
    DatePeriod.last30 => now.subtract(const Duration(days: 30)),
    DatePeriod.last90 => now.subtract(const Duration(days: 90)),
  };
}
