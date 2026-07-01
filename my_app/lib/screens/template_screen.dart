import 'package:flutter/material.dart';

class TemplateScreen extends StatelessWidget {
  const TemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        title: const Text('Templates'),
        backgroundColor: const Color(0xFF8A1538),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.star, color: Colors.amber),
            title: Text(
              'Default',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.white),
            title: Text(
              'Camera',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.flight, color: Colors.white),
            title: Text(
              'Travel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.work, color: Colors.white),
            title: Text(
              'Work',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.add_circle, color: Color(0xFF8A1538)),
            title: Text(
              'Create New Template',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}