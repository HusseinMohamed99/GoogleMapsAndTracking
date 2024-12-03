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
  late GoogleMapController googleMapController;

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
      //
      zoomControlsEnabled: false,
      // initial camera position
      initialCameraPosition: initialCameraPosition,
      // on map created
      onMapCreated: (controller) {
        googleMapController = controller;
        updateCurrentLocation();
      },
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 16,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
    } on LocationServiceException catch (e) {
      log('Error getting location: $e');
    } on LocationPermissionException catch (e) {
      log('Error getting location: $e');
    } catch (e) {
      log('Error getting location: $e');
    }
  }
}
