import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onSettingsChanged;
  final VoidCallback? onSwitchCamera;
  final VoidCallback? onFlash;

  const TopBar({
    super.key,
    this.onSettingsChanged,
    this.onSwitchCamera,
    this.onFlash,
  });

  Future<void> _openSettings(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SettingsScreen(),
      ),
    );

    if (result == true) {
      onSettingsChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 25),
          IconButton(
  onPressed: onFlash,
  icon: const Icon(
    Icons.flash_on,
    color: Colors.white,
    size: 23,
  ),
),
          const Icon(Icons.note_add_outlined, color: Colors.white, size: 23),
          IconButton(
            onPressed: onSwitchCamera,
            icon: const Icon(
              Icons.cameraswitch_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () => _openSettings(context),
            icon: const Icon(
              Icons.settings_suggest_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}