import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/code_input.dart';
import 'package:iyox_wormhole/widgets/large_icon_button.dart';
import 'package:iyox_wormhole/widgets/qr_reader.dart';
import 'package:iyox_wormhole/widgets/shake_widget.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> with SingleTickerProviderStateMixin {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  QRViewController? _qrController;

  bool _qrActive = false;
  String _lastScannedCode = '';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 70),
    );
    _opacityAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    GoRouter.of(context).routeInformationProvider.addListener(() {
      setState(() => _qrActive = false);
      _qrController = null;
    });
  }

  void _toggleQRView() async {
    if (!_qrActive) {
      setState(() => _qrActive = true);
      await _animationController.forward();
    } else {
      await _animationController.reverse();
      setState(() => _qrActive = false);
      _qrController = null;
    }
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await _qrController?.pauseCamera();
    } else if (Platform.isIOS) {
      await _qrController?.resumeCamera();
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
            const bottomSectionHeight = 150.0;
            final availableHeight = constraints.maxHeight - bottomSectionHeight;
            final squareSize =
                availableHeight < constraints.maxWidth ? availableHeight : constraints.maxWidth;

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
                        child: Stack(
                          children: [
                            if (_qrActive)
                              ScaleTransition(
                                scale: _opacityAnimation,
                                child: _buildQRView(),
                              ),
                            Center(
                              child: AnimatedScale(
                                  scale: _qrActive ? 0 : 1,
                                  duration: const Duration(milliseconds: 70),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 0,
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onTap: _toggleQRView,
                                      child: Padding(
                                        padding: const EdgeInsets.all(65.0),
                                        child: Icon(
                                          Icons.qr_code_scanner,
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          size: 37,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(size: Size.fromHeight(10)),
                Column(
                  children: [
                    CodeInput(),
                    SizedBox.fromSize(size: Size.fromHeight(20)),
                    LargeIconButton(
                      onPressed: () => {},
                      label: Text(t.pages.receive.receive_button),
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

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      final code = scanData.code ?? '';
      if (code == '') return;

      if (!code.startsWith('wormhole-transfer:') && _lastScannedCode != code) {
        _shakeKey.currentState?.shake();
        if (await Vibration.hasCustomVibrationsSupport()) {
          await Vibration.vibrate(pattern: [0, 10, 10, 10], amplitude: 40);
        } else {
          await Vibration.vibrate(duration: 10, amplitude: 40);
          await Future.delayed(Duration(milliseconds: 10));
          await Vibration.vibrate(duration: 10, amplitude: 40);
        }
      }

      _lastScannedCode = code;

      if (code.startsWith('wormhole-transfer:')) {
        if (mounted) {
          context.go('/receive/receiving',
              extra: {'code': code.substring('wormhole-transfer:'.length)});
        }
        await Vibration.vibrate(duration: 10, amplitude: 30);
      }
    });
  }

  Widget _buildQRView() {
    return ShakeWidget(
      key: _shakeKey,
      child: Stack(
        children: [
          QrReader(qrKey: _qrKey, onQRViewCreated: _onQRViewCreated),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, size: 32),
              color: Colors.white,
              onPressed: _toggleQRView,
            ),
          ),
        ],
      ),
    );
  }
}
