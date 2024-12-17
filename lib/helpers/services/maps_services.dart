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
}
