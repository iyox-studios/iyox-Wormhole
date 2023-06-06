import 'package:flutter/material.dart';
import 'package:iyox_wormhole/pages/qrCodeScannerPage.dart';
import 'package:iyox_wormhole/pages/receivePage.dart';
import 'package:iyox_wormhole/pages/sendPage.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final pageController = PageController(
    initialPage: 0,
  );

  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedPageIndex = index;
              FocusManager.instance.primaryFocus?.unfocus();
            });
          },
          children: const [
            SendPage(),
            ReceivePage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedPageIndex = index;
            });
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease);
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
          ]),
    );
  }
}