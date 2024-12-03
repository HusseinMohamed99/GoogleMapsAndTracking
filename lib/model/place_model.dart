part of './../core/helpers/export_manager/export_manager.dart';

class PlaceModel {
  int markerId;
  String name;
  LatLng position;

  PlaceModel({
    required this.markerId,
    required this.name,
    required this.position,
  });
}

List<PlaceModel> place = [
  PlaceModel(
    markerId: 1,
    name: 'مستشفى جايدا',
    position: const LatLng(30.053742371919537, 31.329378049427678),
  ),
  PlaceModel(
    markerId: 2,
    name: 'متحف الفن الحديث',
    position: const LatLng(30.048886788019075, 31.335301315375933),
  ),
  PlaceModel(
    markerId: 3,
    name: 'سينما الماسه',
    position: const LatLng(30.060186929863846, 31.317275922350813),
  ),
];
