import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class DataSettingsScreen extends StatefulWidget {
  const DataSettingsScreen({super.key});

  @override
  State<DataSettingsScreen> createState() => _DataSettingsScreenState();
}

class _DataSettingsScreenState extends State<DataSettingsScreen> {
  final SettingsService _settings = SettingsService();

  bool showDate = true;
  bool showTime = true;
  bool showLatitude = true;
  bool showLongitude = true;
  bool showAddress = true;

  bool showAltitude = false;
  bool showSpeed = false;
  bool showCompass = false;
  bool showWeather = false;
  bool showMap = false;
  bool showLogo = false;
  bool showCustomText = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    showDate = await _settings.getBool(_settings.showDateKey, true);
    showTime = await _settings.getBool(_settings.showTimeKey, true);
    showLatitude = await _settings.getBool(_settings.showLatitudeKey, true);
    showLongitude = await _settings.getBool(_settings.showLongitudeKey, true);
    showAddress = await _settings.getBool(_settings.showAddressKey, true);

    showAltitude = await _settings.getBool(_settings.showAltitudeKey, false);
    showSpeed = await _settings.getBool(_settings.showSpeedKey, false);
    showCompass = await _settings.getBool(_settings.showCompassKey, false);
    showWeather = await _settings.getBool(_settings.showWeatherKey, false);
    showMap = await _settings.getBool(_settings.showMapKey, false);
    showLogo = await _settings.getBool(_settings.showLogoKey, false);
    showCustomText =
        await _settings.getBool(_settings.showCustomTextKey, false);

    if (mounted) setState(() {});
  }

  Future<void> _saveSettings() async {
    await _settings.saveBool(_settings.showDateKey, showDate);
    await _settings.saveBool(_settings.showTimeKey, showTime);
    await _settings.saveBool(_settings.showLatitudeKey, showLatitude);
    await _settings.saveBool(_settings.showLongitudeKey, showLongitude);
    await _settings.saveBool(_settings.showAddressKey, showAddress);

    await _settings.saveBool(_settings.showAltitudeKey, showAltitude);
    await _settings.saveBool(_settings.showSpeedKey, showSpeed);
    await _settings.saveBool(_settings.showCompassKey, showCompass);
    await _settings.saveBool(_settings.showWeatherKey, showWeather);
    await _settings.saveBool(_settings.showMapKey, showMap);
    await _settings.saveBool(_settings.showLogoKey, showLogo);
    await _settings.saveBool(_settings.showCustomTextKey, showCustomText);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      activeColor: const Color(0xFF8A1538),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        title: const Text('Data Settings'),
        backgroundColor: const Color(0xFF8A1538),
      ),
      body: ListView(
        children: [
          _buildSwitch('Date', showDate, (v) => setState(() => showDate = v)),
          _buildSwitch('Time', showTime, (v) => setState(() => showTime = v)),
          _buildSwitch('Latitude', showLatitude,
              (v) => setState(() => showLatitude = v)),
          _buildSwitch('Longitude', showLongitude,
              (v) => setState(() => showLongitude = v)),
          _buildSwitch('Address', showAddress,
              (v) => setState(() => showAddress = v)),
          const Divider(color: Colors.white24),
          _buildSwitch('Altitude', showAltitude,
              (v) => setState(() => showAltitude = v)),
          _buildSwitch('Speed', showSpeed, (v) => setState(() => showSpeed = v)),
          _buildSwitch('Compass', showCompass,
              (v) => setState(() => showCompass = v)),
          _buildSwitch('Weather', showWeather,
              (v) => setState(() => showWeather = v)),
          _buildSwitch('Map', showMap, (v) => setState(() => showMap = v)),
          _buildSwitch('Logo', showLogo, (v) => setState(() => showLogo = v)),
          _buildSwitch('Custom Text', showCustomText,
              (v) => setState(() => showCustomText = v)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A1538),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}