import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:vibration/vibration.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR code'),
      ),
      body: SafeArea(
        child: ReaderWidget(
          tryInverted: true,
          onScan: (result) async {
            final code = await _onQrDetect(result.text!, context);
            if (code == '') return;
            if (context.mounted) Navigator.pop(context, code);
          },
        ),
      ),
    );
  }

  Future<String> _onQrDetect(String text, BuildContext context) async {
    debugPrint('Barcode found! $text');

    if (text.startsWith('wormhole-transfer:')) {
      text = text.split(':')[1];
    } else {
      //Toast message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid QR code'),
          duration: Duration(seconds: 2),
        ),
      );
      return '';
    }

    //vibrate
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasAmplitudeControl() ?? false) {
        Vibration.vibrate(duration: 140, amplitude: 2);
      } else {
        Vibration.vibrate(duration: 1000);
      }
    }

    zx.stopCameraProcessing();
    return text;
  }
}
