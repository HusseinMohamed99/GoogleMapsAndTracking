import 'dart:convert';

import 'package:google_maps/model/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:http/http.dart' as http;

class GoogleMapsPlacesService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/';
  final String apiKey = 'AIzaSyA_Sz-vJvykvyFQDSk9cFRgVFK_28K-6nk';
  Future<List<PlaceAutocompleteModel>> getPredictions(
      {required String input}) async {
    // Fetch places from Google Maps Places API
    var response = await http
        .get(Uri.parse('$baseUrl/autocomplete/json?input=$input&key=$apiKey'));

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Parse the response
      var data = jsonDecode(response.body)['predictions'];
      List<PlaceAutocompleteModel> places = [];
      for (var item in data) {
        places.add(PlaceAutocompleteModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception();
    }
  }
}
