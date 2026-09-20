import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_text_styles.dart';

/// The "Home" bottom-nav tab. Deliberately not a `features/` module —
/// it's a composition root that surfaces cards from other bounded
/// contexts (today's tip, upcoming consultation, latest milestone)
/// rather than owning its own domain/data layer. See mobile/README.md
/// for the rationale.
class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back', style: AppTextStyles.headline1),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.consultation),
              child: const Text('Book a consultation'),
            ),
          ],
        ),
      ),
    );
  }
}
