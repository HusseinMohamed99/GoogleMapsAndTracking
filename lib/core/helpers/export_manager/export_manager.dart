import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps/helpers/services/google_maps_places_service.dart';
import 'package:google_maps/model/place_details_model/place_details_model.dart';
import 'package:google_maps/model/routes_body/lat_lng.dart';
import 'package:google_maps/model/routes_model/routes_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/services/routes_service.dart';
import '../../../model/place_autocomplete_model/place_autocomplete_model.dart';
import '../../../model/routes_body/location.dart';
import '../../../model/routes_body/location_info.dart';

part '../../../helpers/services/location_service.dart';
part './../../../model/place_model.dart';
part './../../../widgets/custom_google_map_widget.dart';
part './../../../widgets/custom_google_maps_and_tracking_location.dart';
part './../../../widgets/custom_list_view.dart';
part './../../../widgets/custom_text_field.dart';
