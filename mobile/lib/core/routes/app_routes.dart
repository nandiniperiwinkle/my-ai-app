/// Route path constants. Keep every literal path string here so a typo
/// in a `context.go(...)` call fails at the point of definition, not at
/// runtime navigation.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';

  // Bottom nav shell branches.
  static const String home = '/home';
  static const String wombCare = '/womb-care';
  static const String babyCare = '/baby-care';
  static const String community = '/community';
  static const String profile = '/profile';

  // Reachable via deep link / push from Home or Womb Care, not a nav tab.
  static const String consultation = '/consultation';
}
