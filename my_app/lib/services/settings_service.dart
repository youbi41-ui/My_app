import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _languageKey = 'language';
  static const _showMunicipalityKey = 'showMunicipality';
  static const _showZoneKey = 'showZone';
  static const _municipalityKey = 'municipality';
  static const _zoneKey = 'zone';

  static const _showDateKey = 'showDate';
  static const _showTimeKey = 'showTime';
  static const _showLatitudeKey = 'showLatitude';
  static const _showLongitudeKey = 'showLongitude';
  static const _showAddressKey = 'showAddress';
  static const _showAltitudeKey = 'showAltitude';
  static const _showSpeedKey = 'showSpeed';
  static const _showCompassKey = 'showCompass';
  static const _showWeatherKey = 'showWeather';
  static const _showMapKey = 'showMap';
  static const _showLogoKey = 'showLogo';
  static const _showCustomTextKey = 'showCustomText';

  String get showDateKey => _showDateKey;
  String get showTimeKey => _showTimeKey;
  String get showLatitudeKey => _showLatitudeKey;
  String get showLongitudeKey => _showLongitudeKey;
  String get showAddressKey => _showAddressKey;
  String get showAltitudeKey => _showAltitudeKey;
  String get showSpeedKey => _showSpeedKey;
  String get showCompassKey => _showCompassKey;
  String get showWeatherKey => _showWeatherKey;
  String get showMapKey => _showMapKey;
  String get showLogoKey => _showLogoKey;
  String get showCustomTextKey => _showCustomTextKey;

  Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, value);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'ar';
  }

  Future<void> saveShowMunicipality(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showMunicipalityKey, value);
  }

  Future<bool> getShowMunicipality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showMunicipalityKey) ?? false;
  }

  Future<void> saveShowZone(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showZoneKey, value);
  }

  Future<bool> getShowZone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showZoneKey) ?? false;
  }

  Future<void> saveMunicipality(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_municipalityKey, value);
  }

  Future<String> getMunicipality() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_municipalityKey) ?? 'الوكرة';
  }

  Future<void> saveZone(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_zoneKey, value);
  }

  Future<String> getZone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_zoneKey) ?? 'Zone 1';
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool> getBool(String key, bool defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  Future<void> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}