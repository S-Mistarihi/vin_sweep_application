class AppConfig {
  AppConfig._private();

  static final AppConfig _shared = AppConfig._private();

  factory AppConfig() => _shared;

  bool isDemo = false;
}
