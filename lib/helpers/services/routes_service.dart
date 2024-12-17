import 'dart:convert';

import 'package:google_maps/model/routes_model/routes_model.dart';
import 'package:http/http.dart' as http;

import '../../model/routes_body/routes_body.dart';

class RoutesService {
  final String baseUrl =
      'https://routes.googleapis.com/directions/v2:computeRoutes';
  final String apiKey = 'AIzaSyA_Sz-vJvykvyFQDSk9cFRgVFK_28K-6nk';

  Future<RoutesModel> fetchRoutes({required RoutesBody routesBody}) async {
    Uri url = Uri.parse(baseUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask':
          'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
    };

    var response = await http.post(
      url,
      headers: headers,
      body: routesBody,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return RoutesModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
