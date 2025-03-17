import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrReader extends StatelessWidget {
  const QrReader({super.key, required this.qrKey, required this.onQRViewCreated});

  final Key qrKey;
  final QRViewCreatedCallback onQRViewCreated;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        child: QRView(
          overlay: QrScannerOverlayShape(
              borderRadius: 35,
              borderWidth: 10,
              cutOutSize: constraints.maxWidth,
              overlayColor:
              Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.onTertiaryContainer
          ),
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        ),
      ),
    );
  }
}
