/// Application Configuration
/// Environment-specific settings
class AppConfig {
  final String apiBaseUrl;
  final Duration apiTimeout;
  final bool enableLogging;
  final String environment;

  const AppConfig._({
    required this.apiBaseUrl,
    required this.apiTimeout,
    required this.enableLogging,
    required this.environment,
  });

  /// Development configuration
  static const AppConfig development = AppConfig._(
    apiBaseUrl: 'https://petstore3.swagger.io',
    apiTimeout: Duration(seconds: 30),
    enableLogging: true,
    environment: 'development',
  );

  /// Production configuration
  static const AppConfig production = AppConfig._(
    apiBaseUrl: 'https://petstore3.swagger.io',
    apiTimeout: Duration(seconds: 30),
    enableLogging: false,
    environment: 'production',
  );

  /// Current active configuration
  /// TODO: Change this based on build flavor
  static const AppConfig current = development;

  bool get isDevelopment => environment == 'development';
  bool get isProduction => environment == 'production';
}
