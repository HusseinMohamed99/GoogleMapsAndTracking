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
  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;
  late LatLng currentLocation;
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  List<PlaceAutocompleteModel> places = [];
  late Uuid uuid;
  String? sessionToken;
  late LatLng destination;
  late RoutesService routesService;
  late LocationService locationService;
  late PlacesService placesService;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    textEditingController = TextEditingController();
    placesService = PlacesService();
    uuid = const Uuid();
    routesService = RoutesService();

    fetchPredictions();
    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(
      () async {
        sessionToken ??= uuid.v4();
        if (textEditingController.text.isNotEmpty) {
          var result = await placesService.getPredictions(
            input: textEditingController.text,
            sessionToken: sessionToken!,
          );
          places.clear();
          places.addAll(result);
          setState(() {});
        } else {
          places.clear();
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
              polylines: polyLines,
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
                    textEditingController: textEditingController,
                  ),
                  const SizedBox(height: 16),
                  CustomListView(
                    places: places,
                    googleMapsPlacesService: placesService,
                    onPlaceSelect: (placeDetailsModel) async {
                      textEditingController.clear();
                      places.clear();
                      sessionToken = null;
                      setState(() {});
                      destination = LatLng(
                        placeDetailsModel.geometry!.location!.lat!,
                        placeDetailsModel.geometry!.location!.lng!,
                      );
                      var points = await getRouteData(latLng: destination);
                      displayRoute(points);
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
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      // log('Error getting location: $e');
    } on LocationPermissionException catch (e) {
      // log('Error getting location: $e');
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    } catch (e) {
      // log('Error getting location: $e');
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  Future<List<LatLng>> getRouteData({required LatLng latLng}) async {
    LocationInfoModel origin = LocationInfoModel(
      location: LocationModel(
          latLng: LatLngModel(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      )),
    );
    LocationInfoModel destination = LocationInfoModel(
      location: LocationModel(
          latLng: LatLngModel(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      )),
    );
    RoutesModel routes = await routesService.fetchRoutes(
        origin: origin, destination: destination);
    List<LatLng> points = getDecodedRoute(routes);
    return points;
  }

  List<LatLng> getDecodedRoute(RoutesModel routes) {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> result = polylinePoints
        .decodePolyline(routes.routes!.first.polyline!.encodedPolyline!);
    List<LatLng> route = result.map((PointLatLng point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();
    return route;
  }

  void displayRoute(List<LatLng> points) {
    Polyline route = Polyline(
      color: Colors.blue,
      width: 5,
      polylineId: const PolylineId('route'),
      points: points,
    );
    polyLines.add(route);
    LatLngBounds bounds = getLatLngBounds(points);
    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        32,
      ),
    );
    setState(() {});
  }

  LatLngBounds getLatLngBounds(List<LatLng> points) {
    var southWestLatitude = points.first.latitude;
    var southWestLongitude = points.first.longitude;
    var northWestLatitude = points.first.latitude;
    var northWestLongitude = points.first.longitude;

    for (var point in points) {
      southWestLatitude = min(southWestLatitude, point.latitude);
      southWestLongitude = min(southWestLongitude, point.longitude);
      northWestLatitude = max(northWestLatitude, point.latitude);
      northWestLongitude = max(northWestLongitude, point.longitude);
    }
    return LatLngBounds(
      southwest: LatLng(southWestLatitude, southWestLongitude),
      northeast: LatLng(northWestLatitude, northWestLongitude),
    );
  }
}

// TextField => Search Places
// Build Route => Draw Route between two places

// 1. create TextField
// 2. listen to the textfield
// 3. create a function to search places
// 4. display the search results



// southwest=> min Value LatLng
// northeast=> max Value LatLng
