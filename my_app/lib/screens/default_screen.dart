import 'package:flutter/material.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  String position = 'Bottom Left';
  String fontSize = 'Medium';
  String background = 'Black';
  String fontColor = 'White';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8A1538),
        title: const Text("Default Style"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Position",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: position,
            dropdownColor: Colors.black,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: "Bottom Left",
                child: Text("Bottom Left"),
              ),
              DropdownMenuItem(
                value: "Bottom Right",
                child: Text("Bottom Right"),
              ),
              DropdownMenuItem(
                value: "Top Left",
                child: Text("Top Left"),
              ),
              DropdownMenuItem(
                value: "Top Right",
                child: Text("Top Right"),
              ),
            ],
            onChanged: (v) {
              setState(() {
                position = v!;
              });
            },
          ),

          const SizedBox(height: 25),

          const Text(
            "Font Size",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: fontSize,
            dropdownColor: Colors.black,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: "Small",
                child: Text("Small"),
              ),
              DropdownMenuItem(
                value: "Medium",
                child: Text("Medium"),
              ),
              DropdownMenuItem(
                value: "Large",
                child: Text("Large"),
              ),
            ],
            onChanged: (v) {
              setState(() {
                fontSize = v!;
              });
            },
          ),

          const SizedBox(height: 25),

          const Text(
            "Background",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: background,
            dropdownColor: Colors.black,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: "Black",
                child: Text("Black"),
              ),
              DropdownMenuItem(
                value: "White",
                child: Text("White"),
              ),
              DropdownMenuItem(
                value: "Transparent",
                child: Text("Transparent"),
              ),
            ],
            onChanged: (v) {
              setState(() {
                background = v!;
              });
            },
          ),

          const SizedBox(height: 25),

          const Text(
            "Font Color",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: fontColor,
            dropdownColor: Colors.black,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: "White",
                child: Text("White"),
              ),
              DropdownMenuItem(
                value: "Black",
                child: Text("Black"),
              ),
            ],
            onChanged: (v) {
              setState(() {
                fontColor = v!;
              });
            },
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A1538),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}