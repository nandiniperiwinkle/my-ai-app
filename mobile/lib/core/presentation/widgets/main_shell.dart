import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Persistent bottom-nav scaffold for the `StatefulShellRoute.indexedStack`
/// branches defined in `app_router.dart`. Each tab keeps its own
/// navigation stack and state when switching away and back.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pregnant_woman),
            label: 'Womb Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care),
            label: 'Baby Care',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
