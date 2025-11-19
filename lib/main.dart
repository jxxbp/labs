import 'package:flutter/material.dart';
import 'package:labs/bazar.dart';
import 'package:labs/google_map.dart';

void main() {
  runApp(const LabsApp());
}

class LabsApp extends StatelessWidget {
  const LabsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BazaarMapWidget());
  }
}
