import 'dart:convert';

import 'package:google_maps/model/routes_model/routes_model.dart';
import 'package:http/http.dart' as http;

import '../../model/routes_body/location.dart';
import '../../model/routes_body/route_modifiers.dart';

class RoutesService {
  final String baseUrl =
      'https://routes.googleapis.com/directions/v2:computeRoutes';
  final String apiKey = 'AIzaSyA_Sz-vJvykvyFQDSk9cFRgVFK_28K-6nk';

  Future<RoutesModel> fetchRoutes(
      {required LocationModel origin,
      required LocationModel destination,
      RouteModifiers? routesModifiers}) async {
    Uri url = Uri.parse(baseUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
    };
    Map<String, dynamic> body = {
      "origin": origin.toJson(),
      "destination": destination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": routesModifiers != null
          ? routesModifiers.toJson()
          : RouteModifiers().toJson(),
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return RoutesModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
