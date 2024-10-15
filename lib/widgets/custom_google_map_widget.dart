import 'package:flutter/material.dart';
import 'package:google_maps/model/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.06323964400769, 31.349160175141957),
      zoom: 17,
    );
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  Set<Marker> marker = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          markers: marker,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  const LatLng(30.04908048507987, 31.335826079892914),
                ),
              );
            },
            child: const Text('Update Location'),
          ),
        )
      ],
    );
  }

  void initMapStyle() async {
    var darkMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/maps/dark_map_style.json');
    googleMapController.setMapStyle(darkMapStyle);
  }

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.asset(
        width: 50, const ImageConfiguration(), 'assets/images/pin.png');
    var myMarker = place
        .map(
          (placeModel) => Marker(
            markerId: MarkerId(placeModel.markerId.toString()),
            position: placeModel.position,
            icon: customMarkerIcon,
          ),
        )
        .toSet();

    marker.addAll(myMarker);
    setState(() {});
  }
}
