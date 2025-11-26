import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrScreen extends StatelessWidget {
  final String classId;

  const GenerateQrScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    final sessionData = jsonEncode({
      'sessionId': UniqueKey().toString(), // More robust session generation needed
      'classId': classId,
      'timestamp': DateTime.now().toIso8601String(),
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/class-details/$classId'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: sessionData,
              version: QrVersions.auto,
              size: 250.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Scan this code to mark your attendance',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
