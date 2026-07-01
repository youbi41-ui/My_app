import 'package:flutter/material.dart';
import '../main.dart';

import '../widgets/top_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/info_panel.dart';
import '../widgets/camera_preview.dart';

import '../services/gps_service.dart';
import '../services/camera_service.dart';
import '../services/photo_service.dart';
import '../services/image_stamp_service.dart';
import '../services/settings_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final CameraService _camera = CameraService();
  final PhotoService _photoService = PhotoService();
  final ImageStampService _stampService = ImageStampService();

  int _infoPanelVersion = 0;

  void _refreshInfoPanel() {
    setState(() {
      _infoPanelVersion++;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _camera.start(appCameras);

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _switchCamera() async {
    await _camera.switchCamera(appCameras);

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _toggleFlash() async {
    await _camera.toggleFlash();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _capturePhoto() async {
    final photo = await _camera.capture();

    if (!mounted) return;

    if (photo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الكاميرا غير متاحة على هذا الجهاز'),
        ),
      );
      return;
    }

    final savedPath = await _photoService.savePhoto(photo);

    if (!mounted) return;

    if (savedPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر حفظ الصورة'),
        ),
      );
      return;
    }

    final settings = SettingsService();

    final showDate =
        await settings.getBool(settings.showDateKey, true);

    final showTime =
        await settings.getBool(settings.showTimeKey, true);

    final showLatitude =
        await settings.getBool(settings.showLatitudeKey, true);

    final showLongitude =
        await settings.getBool(settings.showLongitudeKey, true);

    final showAddress =
        await settings.getBool(settings.showAddressKey, true);

    final showAltitude =
        await settings.getBool(settings.showAltitudeKey, false);

    final showSpeed =
        await settings.getBool(settings.showSpeedKey, false);

    final showCompass =
        await settings.getBool(settings.showCompassKey, false);

    final showWeather =
        await settings.getBool(settings.showWeatherKey, false);

    final showMap =
        await settings.getBool(settings.showMapKey, false);

    final showLogo =
        await settings.getBool(settings.showLogoKey, false);

    final showCustomText =
        await settings.getBool(settings.showCustomTextKey, false);

    final now = DateTime.now();

    final date =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    final gps = GpsService();

final coordinates = await gps.getCoordinatesText();
final address = await gps.getAddress();
final altitude = await gps.getAltitude();
final speed = await gps.getSpeed();
final compass = await gps.getCompass();

final parts = coordinates.split(',');

final latitude =
    parts.isNotEmpty ? parts[0].trim() : '--';

final longitude =
    parts.length > 1 ? parts[1].trim() : '--';

final lines = <String>[];

if (showDate) {
  lines.add('Date : $date');
}

if (showTime) {
  lines.add('Time : $time');
}

if (showLatitude) {
  lines.add('Latitude : $latitude');
}

if (showLongitude) {
  lines.add('Longitude : $longitude');
}

if (showAddress && address != '--') {
  lines.add('Address : $address');
}

if (showAltitude && altitude != '--') {
  lines.add('Altitude : $altitude');
}

if (showSpeed && speed != '--') {
  lines.add('Speed : $speed');
}

if (showCompass && compass != '--') {
  lines.add('Compass : $compass');
}

if (showWeather) {
  lines.add('Weather : Not available');
}

if (showMap) {
  lines.add('Map : Not available');
}

if (showLogo) {
  lines.add('Logo : Enabled');
}

if (showCustomText) {
  lines.add('Custom Text : GPS Camera');
}
    

    final stampedPath = await _stampService.stampImage(
      imagePath: savedPath,
      lines: lines,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          stampedPath == null
              ? 'تم حفظ الصورة بدون ختم'
              : 'تم حفظ الصورة مع البيانات',
        ),
      ),
    );
  }
   @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: CameraPreviewBox(
                  controller: _camera.controller,
                  isReady: _camera.isReady,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: TopBar(
                  onSettingsChanged: _refreshInfoPanel,
                  onSwitchCamera: _switchCamera,
                  onFlash: _toggleFlash,
                ),
              ),
              Positioned(
                left: 6,
                right: 6,
                bottom: 105,
                child: InfoPanel(
                  key: ValueKey(_infoPanelVersion),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomBar(
                  onCapture: _capturePhoto,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}