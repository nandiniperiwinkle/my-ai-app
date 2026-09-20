import 'package:flutter/material.dart';

/// Calming, low-stress palette — the app's tone should feel reassuring
/// rather than clinical. Swap these once brand colors are finalized;
/// nothing in the widget tree should reference raw color values directly.
abstract final class AppColors {
  static const Color primary = Color(0xFFE8A0BF); // soft rose
  static const Color secondary = Color(0xFF9CADCE); // muted lavender-blue
  static const Color accent = Color(0xFF7FB77E); // sage green (growth/health)

  static const Color background = Color(0xFFFFFBF7);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF2D2A32);
  static const Color textSecondary = Color(0xFF6E6A75);

  static const Color error = Color(0xFFD64550);
  static const Color success = Color(0xFF4E9F3D);
  static const Color warning = Color(0xFFE0A458);
}
