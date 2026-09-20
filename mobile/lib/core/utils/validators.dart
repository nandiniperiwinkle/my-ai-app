/// Shared form-field validation used across features (auth signup,
/// vitals input, etc). Keep pure and framework-free so it's trivially
/// unit-testable without a widget tree.
abstract final class Validators {
  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');
  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!_phoneRegex.hasMatch(value)) return 'Enter a valid phone number';
    return null;
  }

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    return null;
  }
}
