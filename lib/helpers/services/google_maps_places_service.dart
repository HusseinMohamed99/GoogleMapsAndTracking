import 'dart:convert';

import 'package:google_maps/model/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:google_maps/model/place_details_model/place_details_model.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyA_Sz-vJvykvyFQDSk9cFRgVFK_28K-6nk';

  Future<List<PlaceAutocompleteModel>> getPredictions({
    required String input,
    required String sessionToken,
  }) async {
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

  Future<PlaceDetailsModel> getPlaceDetails({required String placeID}) async {
    // Fetch places from Google Maps Places API
    var response = await http
        .get(Uri.parse('$baseUrl/details/json?place_id=$placeID&key=$apiKey'));

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Parse the response
      var data = jsonDecode(response.body)['result'];

      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
