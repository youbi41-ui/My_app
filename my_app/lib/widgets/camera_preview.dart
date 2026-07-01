import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewBox extends StatelessWidget {
  final CameraController? controller;
  final bool isReady;

  const CameraPreviewBox({
    super.key,
    required this.controller,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    if (isReady && controller != null) {
      return CameraPreview(controller!);
    }

    return Image.network(
      'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=900',
      fit: BoxFit.cover,
    );
  }
}