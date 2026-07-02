import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/qr_service.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/permission_service.dart';
import '../../../../core/utils/extensions.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final QrService _qrService = QrService();
  final PermissionService _permissionService = PermissionService.instance;
  final MobileScannerController _scannerController = MobileScannerController(
    torchEnabled: false,
    formats: const [BarcodeFormat.qrCode],
  );

  bool _hasPermission = false;
  bool _isCheckingPermission = true;
  bool _isProcessing = false;
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    setState(() => _isCheckingPermission = true);
    final granted = await _permissionService.hasCameraPermission();
    if (!mounted) return;
    if (granted) {
      setState(() {
        _hasPermission = true;
        _isCheckingPermission = false;
      });
    } else {
      final requested = await _permissionService.requestCameraPermission();
      if (!mounted) return;
      setState(() {
        _hasPermission = requested;
        _isCheckingPermission = false;
      });
    }
  }

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing || _hasScanned) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;

    final code = barcode.rawValue!;
    if (!_qrService.isValidQrCode(code)) return;

    setState(() {
      _isProcessing = true;
      _hasScanned = true;
    });

    try {
      _scannerController.stop();
      final student = await _qrService.findStudentByQrCode(code);

      if (!mounted) return;

      if (student != null) {
        context.showSuccessSnackBar('${AppStrings.qrCodeFound}: ${student.name}');
        Navigator.of(context).pushReplacementNamed(
          '/student-detail',
          arguments: student,
        );
      } else {
        setState(() {
          _isProcessing = false;
          _hasScanned = false;
        });
        context.showErrorSnackBar(AppStrings.qrCodeNotFound);
        _scannerController.start();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _hasScanned = false;
      });
      context.showErrorSnackBar(e.toString());
      _scannerController.start();
    }
  }

  void _toggleTorch() {
    _scannerController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.qrScanner),
        actions: [
          IconButton(
            onPressed: _toggleTorch,
            icon: const Icon(Icons.flashlight_on),
            tooltip: 'Toggle Flash',
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isCheckingPermission) {
      return const LoadingWidget(message: 'Checking camera permission...');
    }

    if (!_hasPermission) {
      return EmptyState(
        icon: Icons.camera_alt_outlined,
        title: AppStrings.cameraPermissionTitle,
        subtitle: AppStrings.cameraPermissionMessage,
        actionLabel: 'Grant Permission',
        onAction: _checkPermission,
      );
    }

    return Stack(
      children: [
        // Scanner view
        MobileScanner(
          controller: _scannerController,
          onDetect: _onBarcodeDetected,
        ),

        // Scan overlay guide
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            ),
          ),
        ),

        // Top instruction text
        Positioned(
          top: AppSizes.md,
          left: AppSizes.md,
          right: AppSizes.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(AppSizes.radiusButton),
            ),
            child: const Text(
              'Align QR code within the frame',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),

        // Processing overlay
        if (_isProcessing)
          Container(
            color: Colors.black54,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: AppSizes.md),
                  Text(
                    'Processing...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}