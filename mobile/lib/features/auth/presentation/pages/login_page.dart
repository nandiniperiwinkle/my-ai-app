import 'package:flutter/material.dart';

/// Placeholder for Epic 1: Phone/OTP, Google, Apple sign-in.
/// Real implementation lives behind `AuthBloc` + `SignInWithPhone`,
/// `SignInWithGoogle`, `SignInWithApple` usecases (data/domain layers
/// are scaffolded and pending in `features/auth`).
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login — Epic 1: Onboarding & Profiling')),
    );
  }
}
