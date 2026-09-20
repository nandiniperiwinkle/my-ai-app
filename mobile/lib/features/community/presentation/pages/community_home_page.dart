import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Epic 4 (community half): due-date and interest-based support forums.
class CommunityHomePage extends StatelessWidget {
  const CommunityHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community')),
      body: const Center(
        child: Text('Support groups & forums', style: AppTextStyles.headline2),
      ),
    );
  }
}
