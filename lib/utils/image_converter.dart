
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

InputImage? toInputImage(CameraImage image, CameraDescription cameraDescription) {
  final sensorOrientation = cameraDescription.sensorOrientation;
  InputImageRotation? rotation;
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    var rotationCompensation =
        (cameraDescription.lensDirection == CameraLensDirection.front) ? 0 : 90;
    rotation = InputImageRotationValue.fromRawValue(
        (sensorOrientation + rotationCompensation) % 360);
  }

  if (rotation == null) {
    debugPrint('Could not get rotation for the image');
    return null;
  }

  // get image format
  final format = InputImageFormatValue.fromRawValue(image.format.raw);

  // validate format depending on platform
  if (format == null ||
      (defaultTargetPlatform == TargetPlatform.android &&
          format != InputImageFormat.nv21) ||
      (defaultTargetPlatform == TargetPlatform.iOS &&
          format != InputImageFormat.bgra8888)) {
    debugPrint('Invalid image format');
    return null;
  }

  // since format is constraint to nv21 or bgra8888, both only have one plane
  if (image.planes.length != 1) {
    debugPrint('Invalid image plane count');
    return null;
  }
  final plane = image.planes.first;

  // compose InputImage
  return InputImage.fromBytes(
    bytes: plane.bytes,
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: format,
      bytesPerRow: plane.bytesPerRow,
    ),
  );
}
