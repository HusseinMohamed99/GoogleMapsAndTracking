part of './../core/helpers/export_manager/export_manager.dart';

class DisplayPlaces extends StatefulWidget {
  const DisplayPlaces({super.key});

  @override
  State<DisplayPlaces> createState() => _DisplayPlacesState();
}

class _DisplayPlacesState extends State<DisplayPlaces> {
  late TextEditingController textEditingController;
  late GoogleMapsPlacesService googleMapsPlacesService;
  List<PlaceAutocompleteModel> places = [];
  late Uuid uuid;
  String? sessionToken;
  late LatLng destination;
  late RoutesService routesService;
  late LatLng currentLocation;

  @override
  void initState() {
    textEditingController = TextEditingController();
    googleMapsPlacesService = GoogleMapsPlacesService();
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
          var result = await googleMapsPlacesService.getPredictions(
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              CustomTextField(
                prefixIcon: IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
                textEditingController: textEditingController,
              ),
              const SizedBox(height: 16),
              CustomListView(
                places: places,
                googleMapsPlacesService: googleMapsPlacesService,
                onPlaceSelect: (placeDetailsModel) {
                  textEditingController.clear();
                  places.clear();
                  sessionToken = null;
                  setState(() {});
                  destination = LatLng(
                    placeDetailsModel.geometry!.location!.lat!,
                    placeDetailsModel.geometry!.location!.lng!,
                  );
                  getRouteData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getRouteData() {
    RoutesBody routesBody = RoutesBody(
      origin: Origin(
        location: LocationModel(
          latLng: LatLngModel(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude,
          ),
        ),
      ),
      destination: Destination(
        location: LocationModel(
          latLng: LatLngModel(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude,
          ),
        ),
      ),
      travelMode: 'driving',
      routingPreference: 'lessTolls',
      computeAlternativeRoutes: true,
      routeModifiers: RouteModifiers(
        avoidTolls: false,
        avoidHighways: false,
        avoidFerries: false,
      ),
      languageCode: 'en',
      units: 'metric',
    );
    routesService.fetchRoutes(routesBody: routesBody);
  }
}
