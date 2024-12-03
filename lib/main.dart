import 'package:flutter/material.dart';
import 'package:google_maps/core/helpers/export_manager/export_manager.dart';

void main() {
  runApp(const GoogleMapsApp());
}

class GoogleMapsApp extends StatelessWidget {
  const GoogleMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Google Maps And Tracking',
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMapsAndTrackingLocation(),
    );
  }
}
