import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Epic 2: Week-by-Week Tracker, vitals monitoring, Garbh Sanskar
/// mindfulness content, prenatal yoga & nutrition. Real screens are
/// built against `WombCareBloc` once `domain/entities` (e.g.
/// `PregnancyProfile`, `VitalsEntry`) and their usecases land.
class WombCareHomePage extends StatelessWidget {
  const WombCareHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Womb Care')),
      body: const Center(
        child: Text('Week-by-week journey', style: AppTextStyles.headline2),
      ),
    );
  }
}
