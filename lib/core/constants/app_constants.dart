class AppConstants {
  // App Info
  static const String appName = 'E-Commerce';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://api.stryce.com';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int itemsPerPage = 10;
  static const int maxRetries = 3;

  // Cache Duration
  static const Duration defaultCacheDuration = Duration(hours: 24);
  static const Duration productCacheDuration = Duration(hours: 1);

  // UI Configuration
  static const double productGridAspectRatio = 0.7;
  static const int productGridColumns = 2;
  static const double productImageHeight = 200;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
}
