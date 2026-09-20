/// App-wide constants. Values that differ per environment (dev/staging/prod)
/// should be moved to `--dart-define` flavors once CI/CD is wired up
/// (see ROADMAP.md Phase 5).
abstract final class AppConstants {
  static const String appName = 'Maternal Wellness';

  // TODO(auth-sprint): point at the real Firebase Functions base URL per env.
  static const String baseUrl = 'https://api.example.com';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Secure storage keys.
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
}
