import 'package:googleapis/airquality/v1.dart';

class LocationEntity {
  final LatLng coordinates;
  final String address;

  LocationEntity({required this.coordinates, required this.address});
}