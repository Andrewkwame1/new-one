import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/providers/api_providers.dart';
import 'package:myapp/utils/image_converter.dart';

class FaceRecognitionScreen extends ConsumerStatefulWidget {
  final String classId;
  final String studentId;
  final CameraDescription cameraDescription;

  const FaceRecognitionScreen({
    super.key,
    required this.classId,
    required this.studentId,
    required this.cameraDescription,
  });

  @override
  ConsumerState<FaceRecognitionScreen> createState() =>
      _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends ConsumerState<FaceRecognitionScreen> {
  late CameraController _cameraController;
  late FaceDetector _faceDetector;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  String _feedbackMessage = 'Please position your face in the center';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableLandmarks: true,
        enableClassification: true,
        minFaceSize: 0.15,
        enableTracking: true,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    _cameraController = CameraController(
      widget.cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });

    _cameraController.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      final InputImage? inputImage =
          toInputImage(image, widget.cameraDescription);

      if (inputImage == null) {
        _isDetecting = false;
        return;
      }

      _processCameraImage(inputImage);
    });
  }

  Future<void> _processCameraImage(InputImage inputImage) async {
    try {
      final faces = await _faceDetector.processImage(inputImage);

      if (!mounted) return;

      if (faces.isEmpty) {
        setState(() {
          _feedbackMessage = 'No face detected. Please position your face.';
        });
        return;
      }

      if (faces.length > 1) {
        setState(() {
          _feedbackMessage = 'Multiple faces detected. Please show only one face.';
        });
        return;
      }

      final face = faces.first;

      if (face.headEulerAngleY! > 12 || face.headEulerAngleY! < -12) {
        setState(() {
          _feedbackMessage = 'Please look straight at the camera.';
        });
        return;
      }

      setState(() {
        _feedbackMessage = 'Face detected successfully! Marking attendance...';
      });

      await _markAttendance();
    } catch (e) {
      if (mounted) {
        setState(() {
          _feedbackMessage = 'An error occurred during face detection.';
        });
      }
    } finally {
      _isDetecting = false;
    }
  }

  Future<void> _markAttendance() async {
    try {
      await ref
          .read(apiServiceProvider)
          .markAttendance(widget.classId, widget.studentId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attendance marked successfully!')),
        );
        context.go('/student');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error marking attendance: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Recognition'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: _isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(_cameraController),
                CustomPaint(
                  painter: FaceOverlayPainter(),
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      _feedbackMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class FaceOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withAlpha(153)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final facePath = Path()
      ..addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2.2), // Centered oval
        width: size.width * 0.7, // 70% of screen width
        height: size.height * 0.5, // 50% of screen height
      ));

    final combinedPath = Path.combine(
      PathOperation.difference,
      path,
      facePath,
    );

    canvas.drawPath(combinedPath, paint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(facePath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
