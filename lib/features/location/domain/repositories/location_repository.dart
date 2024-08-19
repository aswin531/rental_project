import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getCurrentLocation();
  Future<Map<String, dynamic>> getSearchLocation(String query);
}
