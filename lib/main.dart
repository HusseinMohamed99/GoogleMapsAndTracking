import 'package:flutter/material.dart';
import 'package:google_maps/widgets/custom_google_map_widget.dart';

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
      home: CustomGoogleMap(),
    );
  }
}
