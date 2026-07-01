import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/gps_service.dart';
import '../services/settings_service.dart';

class InfoPanel extends StatefulWidget {
  const InfoPanel({super.key});

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  final SettingsService _settings = SettingsService();

  String language = 'ar';
  bool showMunicipality = false;
  bool showZone = false;
  String municipality = 'الوكرة';
  String zone = 'Zone 1';
  String coordinates = '-- , --';

  bool get isArabic => language == 'ar';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    language = await _settings.getLanguage();
    showMunicipality = await _settings.getShowMunicipality();
    showZone = await _settings.getShowZone();
    municipality = await _settings.getMunicipality();
    zone = await _settings.getZone();
    coordinates = await GpsService().getCoordinatesText();

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormat('dd/MM/yyyy').format(now);
    final time = DateFormat('HH:mm:ss').format(now);

    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.68),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: isArabic ? 'التاريخ' : 'Date',
            value: date,
            isArabic: isArabic,
          ),
          InfoRow(
            label: isArabic ? 'الوقت' : 'Time',
            value: time,
            isArabic: isArabic,
          ),
          InfoRow(
            label: isArabic ? 'الإحداثيات' : 'Coordinates',
            value: coordinates,
            isArabic: isArabic,
          ),
          if (showMunicipality)
            InfoRow(
              label: isArabic ? 'البلدية' : 'Municipality',
              value: municipality,
              isArabic: isArabic,
            ),
          if (showZone)
            InfoRow(
              label: isArabic ? 'الزون' : 'Zone',
              value: zone,
              isArabic: isArabic,
            ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isArabic;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          '$label : $value',
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}