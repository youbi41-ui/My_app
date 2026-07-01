import 'package:flutter/material.dart';
import 'screens/camera_screen.dart';

class FieldCameraApp extends StatelessWidget {
  const FieldCameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field Camera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const CameraScreen(),
    );
  }
}