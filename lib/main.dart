import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.06323964400769, 31.349160175141957),
      zoom: 14,
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps And Tracking',
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: ElevatedButton(
                onPressed: () {
                  googleMapController.animateCamera(
                    CameraUpdate.newLatLng(
                      const LatLng(30.048886788019075, 31.335301315375933),
                    ),
                  );
                },
                child: const Text('Update Location')),
          )
        ],
      ),
    );
  }
}
