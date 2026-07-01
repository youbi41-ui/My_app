import 'package:flutter/material.dart';

import '../screens/gallery_screen.dart';
import '../screens/data_settings_screen.dart';
import '../screens/default_screen.dart';
import '../screens/template_screen.dart';

import 'capture_button.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback? onCapture;

  const BottomBar({
    super.key,
    this.onCapture,
  });

  void _openGallery(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GalleryScreen(),
      ),
    );
  }

  void _openDataSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DataSettingsScreen(),
      ),
    );
  }

  void _openDefault(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DefaultScreen(),
      ),
    );
  }

  void _openTemplates(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TemplateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      color: Colors.black,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _BottomItem(
            icon: Icons.photo_library_outlined,
            label: 'Collection',
            onTap: () => _openGallery(context),
          ),

          _BottomItem(
            icon: Icons.location_on_outlined,
            label: 'Données',
            onTap: () => _openDataSettings(context),
          ),

          CaptureButton(
            onTap: onCapture,
          ),

          _BottomItem(
            icon: Icons.folder_open_outlined,
            label: 'Default',
            onTap: () => _openDefault(context),
          ),

          _BottomItem(
            icon: Icons.grid_view_rounded,
            label: 'Modèle',
            onTap: () => _openTemplates(context),
          ),
        ],
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 27,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}