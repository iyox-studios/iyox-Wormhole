import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/wordlist.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/large_icon_button.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrController;

  String _suggestion = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSuggestion);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSuggestion);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrController!.resumeCamera();
    }
  }

  void _updateSuggestion() {
    final input = _controller.text;
    if (input.isEmpty) {
      setState(() => _suggestion = '');
      return;
    }
    // Find the first matching word from the list (case insensitive)
    final match = wordlist.firstWhere(
      (word) => word.toLowerCase().startsWith(input.toLowerCase()),
      orElse: () => '',
    );
    setState(() {
      _suggestion = match;
    });
  }

  void _acceptSuggestion() {
    if (_suggestion.isNotEmpty &&
        _suggestion.toLowerCase().startsWith(_controller.text.toLowerCase())) {
      setState(() {
        _controller.text = _suggestion;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        _suggestion = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.receive,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const bottomSectionHeight =
                150.0; // Total height of your bottom widgets
            final availableHeight = constraints.maxHeight - bottomSectionHeight;
            final squareSize = availableHeight < constraints.maxWidth
                ? availableHeight
                : constraints.maxWidth;

            return Column(
              children: [
                SizedBox(
                  height: availableHeight,
                  child: Center(
                    child: SizedBox(
                      width: squareSize,
                      height: squareSize,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: LayoutBuilder(
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
                              onQRViewCreated: _onQRViewCreated,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(size: Size.fromHeight(10)),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightenOrDarken(
                          Theme.of(context).colorScheme.surfaceContainerHigh,
                          0.03,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(240),
                        ),
                        hintText: 'Enter Code',
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                    SizedBox.fromSize(size: Size.fromHeight(20)),
                    LargeIconButton(
                      onPressed: () => {},
                      label: Text('Receive File'),
                      icon: Icons.sim_card_download_outlined,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color lightenOrDarken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);

    final lightness = Theme.of(context).brightness == Brightness.dark
        ? hsl.lightness + amount
        : hsl.lightness - amount;
    final hslTinted = hsl.withLightness((lightness).clamp(0.0, 1.0));

    return hslTinted.toColor();
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        debugPrint(scanData.code);
        //result = scanData;
      });
    });
  }
}
