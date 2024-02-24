import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iyox_wormhole/gen/ffi.dart';
import 'package:iyox_wormhole/pages/QrCodeScannerPage.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:iyox_wormhole/utils/paths.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  String code = '';
  int totalReceiveBytes = 0;
  int receivedBytes = 0;
  bool transferring = false;
  bool downloadStarted = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 55, 0, 20),
          child: Text("Receive Files", style: TextStyle(fontSize: 37)),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      enabled: !transferring,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        label: Text('Code'),
                      ),
                      autocorrect: false,
                      onChanged: (value) => setState(
                        () => code = value,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: !transferring ? _onQrButtonClicked : null,
                      icon: const Icon(Icons.qr_code)),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: !transferring
                ? FilledButton.icon(
                    onPressed: _onReceiveButtonClick,
                    style: buttonStyle,
                    label: const Text('Receive File'),
                    icon: const Icon(Icons.sim_card_download_outlined),
                  )
                : LinearProgressIndicator(
                    value: downloadStarted
                        ? receivedBytes / totalReceiveBytes
                        : null,
                    minHeight: 13,
                    borderRadius: BorderRadius.circular(18),
                  ),
          ),
        ),
      ],
    ));
  }

  static final ButtonStyle buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
    ),
    fixedSize: MaterialStateProperty.all<Size>(const Size(180, 60)),
  );

  void _onQrButtonClicked() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const QRScannerPage()));

    if (!mounted) return;

    if (result != null) {
      setState(() {
        code = result;
      });
    }

    _onReceiveButtonClick();
  }

  Future<ServerConfig> _getServerConfig() async {
    final rendezvousUrl = await api.defaultRendezvousUrl();
    final transitUrl = await api.defaultTransitUrl();
    final serverConfig =
        ServerConfig(rendezvousUrl: rendezvousUrl, transitUrl: transitUrl);
    return serverConfig;
  }

  void _onReceiveButtonClick() async {
    //if (!isCodeValid(text) || !mounted) {
    //return;
    //}

    if (code.isEmpty) {
      return;
    }

    final downloadPath = await getDownloadPath() ?? '';

    debugPrint('code: $code');
    final stream = api.requestFile(
        passphrase: code,
        storageFolder: downloadPath,
        serverConfig: await _getServerConfig());

    setState(() {
      transferring = true;
      downloadStarted = false;
    });

    stream.listen((e) {
      debugPrint(e.event.toString());
      switch (e.event) {
        case Events.StartTransfer:
          setState(() {
            downloadStarted = true;
          });
        case Events.Finished:
          setState(() {
            transferring = false;
          });
          break;

        case Events.Sent:
          setState(() {
            receivedBytes = e.getValue();
          });
          break;
        case Events.Total:
          setState(() {
            totalReceiveBytes = e.getValue();
          });
          break;

        case Events.Error:
          debugPrint('Error: ${e.getValue()}');

          setState(() {
            transferring = false;
          });
        case Events.ConnectionType:
          //connectionType = (e.value as Value_ConnectionType).field0;
          //connectionTypeName = (e.value as Value_ConnectionType).field1;
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
