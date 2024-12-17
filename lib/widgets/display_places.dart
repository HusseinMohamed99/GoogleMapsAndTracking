// part of './../core/helpers/export_manager/export_manager.dart';

// class DisplayPlaces extends StatefulWidget {
//   const DisplayPlaces({super.key, required this.currentLocation});
//   final LatLng currentLocation;
//   @override
//   State<DisplayPlaces> createState() => _DisplayPlacesState();
// }

// class _DisplayPlacesState extends State<DisplayPlaces> {
//   late TextEditingController textEditingController;
//   late GoogleMapsPlacesService googleMapsPlacesService;
//   List<PlaceAutocompleteModel> places = [];
//   late Uuid uuid;
//   String? sessionToken;
//   late LatLng destination;
//   late RoutesService routesService;

//   @override
//   void initState() {
//     textEditingController = TextEditingController();
//     googleMapsPlacesService = GoogleMapsPlacesService();
//     uuid = const Uuid();
//     routesService = RoutesService();

//     fetchPredictions();
//     super.initState();
//   }

//   void fetchPredictions() {
//     textEditingController.addListener(
//       () async {
//         sessionToken ??= uuid.v4();
//         if (textEditingController.text.isNotEmpty) {
//           var result = await googleMapsPlacesService.getPredictions(
//             input: textEditingController.text,
//             sessionToken: sessionToken!,
//           );
//           places.clear();
//           places.addAll(result);
//           setState(() {});
//         } else {
//           places.clear();
//           setState(() {});
//         }
//       },
//     );
//   }

//   @override
//   void dispose() {
//     textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 16,
//           ),
//           child: Column(
//             children: [
//               CustomTextField(
//                 prefixIcon: IconButton(
//                   icon: const Icon(FontAwesomeIcons.arrowLeft),
//                   onPressed: () {
//                     if (Navigator.canPop(context)) {
//                       Navigator.pop(context);
//                     }
//                   },
//                 ),
//                 textEditingController: textEditingController,
//               ),
//               const SizedBox(height: 16),
//               CustomListView(
//                 places: places,
//                 googleMapsPlacesService: googleMapsPlacesService,
//                 onPlaceSelect: (placeDetailsModel) {
//                   textEditingController.clear();
//                   places.clear();
//                   sessionToken = null;
//                   setState(() {});
//                   destination = LatLng(
//                     placeDetailsModel.geometry!.location!.lat!,
//                     placeDetailsModel.geometry!.location!.lng!,
//                   );
//                   var points = getRouteData();
//                   displayRoute(points);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<List<LatLng>> getRouteData() async {
//     LocationModel origin = LocationModel(
//       latLng: LatLngModel(
//         latitude: widget.currentLocation.latitude,
//         longitude: widget.currentLocation.longitude,
//       ),
//     );
//     LocationModel destination = LocationModel(
//       latLng: LatLngModel(
//         latitude: widget.currentLocation.latitude,
//         longitude: widget.currentLocation.longitude,
//       ),
//     );
//     RoutesModel routes = await routesService.fetchRoutes(
//       origin: origin,
//       destination: destination,
//     );

//     List<LatLng> route = getDecodedRoute(routes);
//     return route;
//   }

//   List<LatLng> getDecodedRoute(RoutesModel routes) {
//     PolylinePoints polylinePoints = PolylinePoints();

//     List<PointLatLng> result = polylinePoints
//         .decodePolyline(routes.routes!.first.polyline!.encodedPolyline!);
//     List<LatLng> route = result.map((PointLatLng point) {
//       return LatLng(point.latitude, point.longitude);
//     }).toList();
//     return route;
//   }

//   void displayRoute(List<LatLng> points) {
//     Polyline route = Polyline(
//       color: Colors.blue,
//       width: 5,
//       polylineId: const PolylineId('route'),
//       points: points,
//     );
//     polyline.add(route);
//     setState(() {});
//   }
// }
