import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late final MobileScannerController _qrController;

  @override
  void initState() {
    super.initState();
    _qrController = MobileScannerController();
  }

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          // Rotate Camera
          IconButton(
            onPressed: _qrController.switchCamera,
            icon: ValueListenableBuilder<CameraFacing>(
              valueListenable: _qrController.cameraFacingState,
              builder: (_, state, __) {
                return state == CameraFacing.front
                    ? const Icon(Icons.camera_front_rounded)
                    : const Icon(Icons.camera_rear_rounded);
              },
            ),
          ),

          // Flash On/Off
          ValueListenableBuilder<CameraFacing>(
            valueListenable: _qrController.cameraFacingState,
            builder: (_, state, child) {
              return state == CameraFacing.back
                  ? child!
                  : const SizedBox.shrink();
            },
            child: IconButton(
              onPressed: _qrController.toggleTorch,
              icon: ValueListenableBuilder<TorchState>(
                valueListenable: _qrController.torchState,
                builder: (_, state, __) {
                  return state == TorchState.on
                      ? const Icon(Icons.lightbulb_rounded)
                      : const Icon(Icons.lightbulb_outline);
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Instructions
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Please scan the QR code printed on the back side of your IBA ID card.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLightGreyColor,
              ),
            ),
          ),

          Insets.gapH30,

          // Scanner
          SizedBox(
            height: 300,
            width: 300,
            child: MobileScanner(
              controller: _qrController,
              onDetect: (barcode, args) {
                final code = barcode.rawValue;
                AppRouter.pop(code);
              },
            ),
          )
        ],
      ),
    );
  }
}
