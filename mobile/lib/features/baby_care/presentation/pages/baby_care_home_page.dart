import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Epic 3: Fourth Trimester — feeding/sleep/diaper trackers, postpartum
/// recovery plans, month-by-month milestone mapping.
class BabyCareHomePage extends StatelessWidget {
  const BabyCareHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baby Care')),
      body: const Center(
        child: Text('Baby & recovery trackers', style: AppTextStyles.headline2),
      ),
    );
  }
}
