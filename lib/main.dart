import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/themed_app.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings
  await SharedPrefs().init();

  // Display Mode
  if (kReleaseMode && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  // Logging
  final logger = getLogger();
  if (kDebugMode) {
    Logger.level = Level.debug;
  } else {
    Logger.level = Level.warning;
  }

  FlutterError.onError = (details) {
    FlutterError.presentError(details);

    logger.f(
      'Uncaught Error: ${details.toString()} - ${details.exception}',
      error: details,
      stackTrace: details.stack,
    );
  };

  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  static final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        //redirect: (context, state) => initialLocation,
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => MyHomePage(
          title: 'Test',
        ),
      ),
    ],
  );

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //StreamSubscription? _intentDataStreamSubscription;

  @override
  void initState() {
    //setupSharingIntent();
    super.initState();
  }

  /*
  void setupSharingIntent() {
    if (Platform.isAndroid || Platform.isIOS) {
      // for files opened while the app is closed
      ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> files) {
        for (final file in files) {
          App.openFile(file);
        }
      });

      // for files opened while the app is open
      final stream = ReceiveSharingIntent.instance.getMediaStream();
      _intentDataStreamSubscription = stream.listen((List<SharedMediaFile> files) {
        for (final file in files) {
          App.openFile(file);
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      title: 'Saber',
      router: App._router,
    );
  }

  @override
  void dispose() {
    //_intentDataStreamSubscription?.cancel();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              t.common.test,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
