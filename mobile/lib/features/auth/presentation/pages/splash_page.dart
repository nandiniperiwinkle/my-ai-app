import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

/// TODO(auth-sprint): replace the fixed delay with a real session check
/// (read stored token via `AuthLocalDataSource`, call `GetCurrentUser`
/// usecase) and route to [AppRoutes.login] when there's no valid session.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Icon(Icons.favorite, color: AppColors.primary, size: 64),
      ),
    );
  }
}
