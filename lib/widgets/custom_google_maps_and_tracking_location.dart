part of './../core/helpers/export_manager/export_manager.dart';

class CustomGoogleMapsAndTrackingLocation extends StatefulWidget {
  const CustomGoogleMapsAndTrackingLocation({super.key});

  @override
  State<CustomGoogleMapsAndTrackingLocation> createState() =>
      _CustomGoogleMapsAndTrackingLocationState();
}

class _CustomGoogleMapsAndTrackingLocationState
    extends State<CustomGoogleMapsAndTrackingLocation> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 13,
      target: LatLng(0, 0),
    );
    locationService = LocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // Add initial camera position
      initialCameraPosition: initialCameraPosition,
    );
  }
}