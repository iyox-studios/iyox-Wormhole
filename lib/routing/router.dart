import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/main.dart';
import 'package:iyox_wormhole/pages/receive_page.dart';
import 'package:iyox_wormhole/pages/send_page.dart';
import 'package:iyox_wormhole/pages/settings_page.dart';
import 'package:iyox_wormhole/routing/shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellSendNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'send');
final GlobalKey<NavigatorState> _shellReceiveNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'receive');
final GlobalKey<NavigatorState> _shellSettingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

final goRouter = GoRouter(
  initialLocation: '/send',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellSendNavigatorKey,
          routes: [
            GoRoute(
              path: '/send',
              builder: (context, state) => SendPage(),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellReceiveNavigatorKey,
          routes: [
            GoRoute(
              path: '/receive',
              builder: (context, state) => ReceivePage(),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellSettingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
            )
          ],
        ),
      ],
    )
  ],
);
