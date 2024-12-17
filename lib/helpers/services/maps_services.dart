part of './../../core/helpers/export_manager/export_manager.dart';

class MapsServices {
  PlacesService placesService = PlacesService();
  LocationService locationService = LocationService();
  RoutesService routesService = RoutesService();

  getPredictions({
    required String input,
    required String sessionToken,
    required List<PlaceAutocompleteModel> places,
  }) async {
    if (input.isNotEmpty) {
      var result = await placesService.getPredictions(
        input: input,
        sessionToken: sessionToken,
      );
      places.clear();
      places.addAll(result);
    } else {
      places.clear();
    }
  }

  Future<List<LatLng>> getRouteData({
    required LatLng currentLocation,
    required LatLng newDestination,
  }) async {
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
        latitude: newDestination.latitude,
        longitude: newDestination.longitude,
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
}
