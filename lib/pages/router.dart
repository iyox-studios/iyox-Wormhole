import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:iyox_wormhole/pages/settings_page.dart';
import 'package:iyox_wormhole/pages/receive_page.dart';
import 'package:iyox_wormhole/pages/send_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedPageIndex = 0;

  static const List<Widget> pages = <Widget>[
    SendPage(),
    ReceivePage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child),
          child: pages[selectedPageIndex],
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: selectedPageIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                tooltip: 'Send',
                icon: Icon(Icons.upload_outlined),
                label: 'Send',
                selectedIcon: Icon(Icons.upload_rounded),
              ),
              NavigationDestination(
                tooltip: 'Receive',
                icon: Icon(Icons.download_outlined),
                label: 'Receive',
                selectedIcon: Icon(Icons.download_rounded),
              ),
              NavigationDestination(
                tooltip: 'Settings',
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
                selectedIcon: Icon(Icons.settings_rounded),
              ),
            ]),
      ),
    );
  }
}
