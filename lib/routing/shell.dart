import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            label: t.common.navbar.send,
            icon: Icon(Icons.upload_outlined),
            selectedIcon: Icon(Icons.upload),
          ),
          NavigationDestination(
            label: t.common.navbar.receive,
            icon: Icon(Icons.download_outlined),
            selectedIcon: Icon(Icons.download),
          ),
          NavigationDestination(
            label: t.common.navbar.settings,
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
          ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
