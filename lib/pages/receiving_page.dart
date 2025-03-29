import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/rust/wormhole/types/events.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:path_provider/path_provider.dart';

class ReceivingPage extends StatefulWidget {
  const ReceivingPage({super.key, required this.code});

  final String code;

  @override
  State<ReceivingPage> createState() => _ReceivingPageState();
}

class _ReceivingPageState extends State<ReceivingPage> {
  int totalReceiveBytes = 0;
  int receivedBytes = 0;
  bool transferring = false;
  bool downloadStarted = false;
  final _prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    startReceiving();
  }

  void startReceiving() async {
    final downloadPath = await getDownloadsDirectory();

    if (downloadPath == null) {
      Navigator.of(context).pop();
      return;
    }

    final serverConfig = ServerConfig(
      rendezvousUrl: _prefs.rendezvousUrl,
      transitUrl: _prefs.transitUrl,
    );

    final stream = requestFile(
        code: widget.code,
        storageFolder: downloadPath.path,
        serverConfig: serverConfig);

    setState(() {
      transferring = true;
      downloadStarted = false;
    });

    stream.listen((e) {
      debugPrint(e.event.toString());
      switch (e.event) {
        case Events.startTransfer:
          setState(() {
            downloadStarted = true;
          });
        case Events.finished:
          setState(() {
            transferring = false;
          });
          break;

        case Events.sent:
          setState(() {
            receivedBytes = e.getValue() as int;
          });
          break;
        case Events.total:
          setState(() {
            totalReceiveBytes = e.getValue() as int;
          });
          break;

        case Events.error:
          debugPrint('Error: ${e.getValue()}');

          setState(() {
            transferring = false;
          });
        case Events.connectionType:
          //connectionType = (e.value as Value_ConnectionType).field0;
          //connectionTypeName = (e.value as Value_ConnectionType).field1;
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(
              value: downloadStarted ? receivedBytes / totalReceiveBytes : null,
              minHeight: 13,
              borderRadius: BorderRadius.circular(18),
            ),
          ],
        ),
      ),
    );
  }
}
