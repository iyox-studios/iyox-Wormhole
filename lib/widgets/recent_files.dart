import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../pages/sending_page.dart';
import '../utils/settings.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({super.key});

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles>
    with SingleTickerProviderStateMixin {
  bool recentCollapsed = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      upperBound: 0.5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: double.infinity,
        curve: Curves.easeInOutCirc,
        height: recentCollapsed ? 80 : null,
        constraints: const BoxConstraints(minHeight: 80, maxHeight: 340),
        duration: const Duration(milliseconds: 150),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Card(
            elevation: 1,
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            child: Wrap(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                  child: Row(children: [
                    const Text(
                      "Recent files",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child: IconButton.filledTonal(
                            iconSize: 23,
                            padding: const EdgeInsets.all(0),
                            constraints:
                                BoxConstraints.tight(const Size.square(25)),
                            onPressed: () => {
                                  setState(() {
                                    if (recentCollapsed) {
                                      _controller.reverse(from: 0.5);
                                    } else {
                                      _controller.forward(from: 0.0);
                                    }
                                    recentCollapsed = !recentCollapsed;
                                  })
                                },
                            icon: const Icon(Icons.keyboard_arrow_down)))
                  ]),
                ),
                FutureBuilder(
                    future: Settings.getRecentFiles(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 222,
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              final file = snapshot.data![snapshot.data!.length - index - 1];
                              return ListTile(
                                  onTap: () => {
                                        Navigator.push(
                                            context, _createSendingRoute(file))
                                      },
                                  title: Text(
                                    file.split('/').last,
                                    style: const TextStyle(fontSize: 16),
                                  ));
                            },
                          ),
                        );
                      }
                      return const Placeholder();
                    }),
              ]),
            ]),
          ),
        ));
  }

  Route _createSendingRoute(String path) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SendingPage(
        files: [path],
      ),
      transitionDuration: const Duration(milliseconds: 0),
      reverseTransitionDuration: const Duration(milliseconds: 380),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeThroughTransition(
              secondaryAnimation: secondaryAnimation,
              animation: animation,
              child: child),
    );
  }
}
