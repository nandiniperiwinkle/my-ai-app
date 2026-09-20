import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Epic 4 (expert-access half): live AMAs and 1-on-1 booking. Reached via
/// a push from Home/Womb Care rather than a bottom-nav tab — see
/// `AppRoutes.consultation`.
class ConsultationHomePage extends StatelessWidget {
  const ConsultationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experts & Consultations')),
      body: const Center(
        child: Text('Book a consultation', style: AppTextStyles.headline2),
      ),
    );
  }
}
