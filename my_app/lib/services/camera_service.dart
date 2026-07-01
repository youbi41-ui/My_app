import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;
  bool isReady = false;
bool flashEnabled = false;
int currentCameraIndex = 0;

  Future<void> start(List<CameraDescription> cameras) async {
    if (cameras.isEmpty) {
      isReady = false;
      return;
    }

    await _initializeCamera(cameras, currentCameraIndex);
  }

  Future<void> switchCamera(List<CameraDescription> cameras) async {
    if (cameras.length < 2) return;

    currentCameraIndex = (currentCameraIndex + 1) % cameras.length;

    await controller?.dispose();
    isReady = false;

    await _initializeCamera(cameras, currentCameraIndex);
  }

  Future<void> _initializeCamera(
    List<CameraDescription> cameras,
    int index,
  ) async {
    controller = CameraController(
      cameras[index],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller!.initialize();
      isReady = true;
    } catch (_) {
      isReady = false;
    }
  }
Future<void> toggleFlash() async {
  if (controller == null || !isReady) return;

  try {
    flashEnabled = !flashEnabled;

    await controller!.setFlashMode(
      flashEnabled ? FlashMode.torch : FlashMode.off,
    );
  } catch (_) {
    flashEnabled = false;
  }
}
  Future<XFile?> capture() async {
    if (!isReady || controller == null) return null;

    try {
      return await controller!.takePicture();
    } catch (_) {
      return null;
    }
  }

  Future<void> dispose() async {
    await controller?.dispose();
  }
}