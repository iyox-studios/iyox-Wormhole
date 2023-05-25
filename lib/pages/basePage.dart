import 'package:flutter/material.dart';

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
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        children: const [
          Text('asd'),
          Text('Test'),
        ],
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
              tooltip: 'Receive',
              icon: Icon(Icons.school_outlined),
              label: 'Receive',
              selectedIcon: Icon(Icons.school_rounded),
            ),
            NavigationDestination(
              tooltip: 'Send',
              icon: Icon(Icons.library_books_outlined),
              label: 'Send',
              selectedIcon: Icon(Icons.library_books_rounded),
            )
          ]),
    );
  }
}