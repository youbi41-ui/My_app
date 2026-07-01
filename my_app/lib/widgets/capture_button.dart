import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CaptureButton({
    super.key,
    this.onTap,
  });

  static const Color maroon = Color(0xFF8A1538);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Center(
          child: Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: maroon,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}