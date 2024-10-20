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
      zoom: 1,
      target: LatLng(31.187084851056554, 29.928110526889437),
    );
    // initMarkers();
    // initPolyLines();
    initPolygons();
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
  Set<Polygon> polygons = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          // markers: marker,
          // polylines: polyLines,
          polygons: polygons,
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
    var polyLineA = const Polyline(
      geodesic: true,
      startCap: Cap.roundCap,
      polylineId: PolylineId('1'),
      color: Colors.red,
      width: 5,
      zIndex: 2,
      points: [
        LatLng(30.069322602887198, 31.312299884707596),
        LatLng(30.065068100493647, 31.289358512123748),
        LatLng(30.05831829856399, 31.303347894085647),
        LatLng(30.05059617080793, 31.31934009428447),
      ],
    );
    var polyLineB = const Polyline(
      geodesic: true,
      startCap: Cap.roundCap,
      polylineId: PolylineId('2'),
      color: Colors.green,
      width: 5,
      zIndex: 1,
      points: [
        LatLng(30.056427220695184, 31.31703381873318),
        LatLng(30.0481795988592, 31.30999360915583),
      ],
    );
    polyLines.add(polyLineA);
    polyLines.add(polyLineB);
    setState(() {});
  }

  void initPolygons() {
    Polygon polygon = Polygon(
      polygonId: const PolygonId('1'),
      fillColor: Colors.black.withOpacity(0.5),
      strokeWidth: 1,
      strokeColor: Colors.red,
      holes: const [
        [
          LatLng(30.060280998829203, 31.505664500439217),
          LatLng(30.11355587976404, 31.342828576515803),
          LatLng(30.05160244782071, 31.2204202635576),
          LatLng(30.0835832583514, 31.188085992210144),
        ],
      ],
      points: const [
        LatLng(31.5, 25.0),
        LatLng(31.5, 28.0),
        LatLng(31.2, 30.0),
        LatLng(31.0, 32.0),
        LatLng(31.0, 34.0),
        LatLng(31.0, 34.0),
        LatLng(29.5, 34.5),
        LatLng(28.0, 34.5),
        LatLng(25.0, 34.0),
        LatLng(25.0, 34.0),
        LatLng(22.0, 36.0),
        LatLng(22.0, 36.0),
        LatLng(22.0, 31.0),
        LatLng(22.0, 25.0),
        LatLng(22.0, 25.0),
        LatLng(25.0, 25.0),
        LatLng(31.5, 25.0)
      ],
    );
    polygons.add(polygon);
  }
}
