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
  late LatLng currentLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // to avoid bottom overflow
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              markers: markers,
              zoomControlsEnabled: false,
              // initial camera position
              initialCameraPosition: initialCameraPosition,
              // on map created
              onMapCreated: (controller) {
                googleMapController = controller;
                updateCurrentLocation();
              },
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  CustomTextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DisplayPlaces();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      Marker currentLocationMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentLocation,
      );
      CameraPosition newCameraPosition = CameraPosition(
        target: currentLocation,
        zoom: 16,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
      markers.add(currentLocationMarker);
      setState(() {});
    } on LocationServiceException catch (e) {
      log('Error getting location: $e');
    } on LocationPermissionException catch (e) {
      log('Error getting location: $e');
    } catch (e) {
      log('Error getting location: $e');
    }
  }
}

// TextField => Search Places
// Build Route => Draw Route between two places

// 1. create TextField
// 2. listen to the textfield
// 3. create a function to search places
// 4. display the search results
