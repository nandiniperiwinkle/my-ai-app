import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Bottom-nav "Profile" tab. Owned by the `auth` feature since progressive
/// profiling (due date, pregnancy stage, health goals) is Epic 1.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('Your profile', style: AppTextStyles.headline2),
      ),
    );
  }
}
