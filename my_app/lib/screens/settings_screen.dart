import 'package:flutter/material.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settings = SettingsService();

  String language = 'ar';
  bool showMunicipality = false;
  bool showZone = false;
  String municipality = 'الوكرة';
  String zone = 'Zone 1';

  final List<String> municipalities = [
    'الدوحة',
    'الريان',
    'الوكرة',
    'أم صلال',
    'الظعاين',
    'الخور والذخيرة',
    'الشمال',
    'الشيحانية',
  ];

  final List<String> zones = [
    'Zone 1',
    'Zone 2',
    'Zone 3',
    'Zone 4',
    'Zone 5',
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    language = await _settings.getLanguage();
    showMunicipality = await _settings.getShowMunicipality();
    showZone = await _settings.getShowZone();
    municipality = await _settings.getMunicipality();
    zone = await _settings.getZone();

    if (mounted) setState(() {});
  }

  Future<void> _saveSettings() async {
    await _settings.saveLanguage(language);
    await _settings.saveShowMunicipality(showMunicipality);
    await _settings.saveShowZone(showZone);
    await _settings.saveMunicipality(municipality);
    await _settings.saveZone(zone);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  bool get isArabic => language == 'ar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A1538),
        title: Text(isArabic ? 'الإعدادات' : 'Settings'),
      ),
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle(isArabic ? 'اللغة' : 'Language'),

            RadioListTile<String>(
              value: 'ar',
              groupValue: language,
              activeColor: const Color(0xFF8A1538),
              title: const Text('العربية', style: TextStyle(color: Colors.white)),
              onChanged: (value) => setState(() => language = value!),
            ),

            RadioListTile<String>(
              value: 'en',
              groupValue: language,
              activeColor: const Color(0xFF8A1538),
              title: const Text('English', style: TextStyle(color: Colors.white)),
              onChanged: (value) => setState(() => language = value!),
            ),

            const SizedBox(height: 16),

            _sectionTitle(isArabic ? 'معلومات اختيارية' : 'Optional Info'),

            SwitchListTile(
              value: showMunicipality,
              activeColor: const Color(0xFF8A1538),
              title: Text(
                isArabic ? 'إظهار البلدية' : 'Show Municipality',
                style: const TextStyle(color: Colors.white),
              ),
              onChanged: (value) => setState(() => showMunicipality = value),
            ),

            if (showMunicipality)
              _dropdown(
                value: municipality,
                items: municipalities,
                onChanged: (value) => setState(() => municipality = value!),
              ),

            SwitchListTile(
              value: showZone,
              activeColor: const Color(0xFF8A1538),
              title: Text(
                isArabic ? 'إظهار الزون' : 'Show Zone',
                style: const TextStyle(color: Colors.white),
              ),
              onChanged: (value) => setState(() => showZone = value),
            ),

            if (showZone)
              _dropdown(
                value: zone,
                items: zones,
                onChanged: (value) => setState(() => zone = value!),
              ),

            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A1538),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                isArabic ? 'حفظ' : 'Save',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: Colors.black,
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.white),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}