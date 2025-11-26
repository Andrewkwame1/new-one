import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  final String studentId;

  const ScanQrScreen({super.key, required this.studentId});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  late MobileScannerController controller;
  late CameraDescription cameraDescription;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    // Use the front camera for face recognition
    cameraDescription = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/student'),
        ),
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final String? code = capture.barcodes.first.rawValue;
          if (code != null) {
            try {
              final Map<String, dynamic> data = jsonDecode(code);
              final String classId = data['classId'];
              context.go(
                '/face-recognition/$classId?studentId=${widget.studentId}',
                extra: cameraDescription,
              );
            } catch (e) {
              // Handle JSON parsing errors or missing keys
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid QR code. Please scan again.'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
