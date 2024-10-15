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
    initPolyLines();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;

  Set<Marker> marker = {};
  Set<Polyline> polyLines = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: marker,
          polylines: polyLines,
          zoomControlsEnabled: false,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
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
                  const LatLng(30.05059617080793, 31.31934009428447),
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

  void initPolyLines() {
    var polyLine = const Polyline(
      polylineId: PolylineId('1'),
      color: Colors.red,
      width: 5,
      points: [
        LatLng(30.069322602887198, 31.312299884707596),
        LatLng(30.065068100493647, 31.289358512123748),
        LatLng(30.05831829856399, 31.303347894085647),
        LatLng(30.05059617080793, 31.31934009428447),
      ],
    );
    polyLines.add(polyLine);
    setState(() {});
  }
}
