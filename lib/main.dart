import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Google Maps And Tracking',
      debugShowCheckedModeBanner: false,
      home: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.065797066044176, 31.34539452646555),
        ),
      ),
    );
  }
}
