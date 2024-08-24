import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/domain/entity/location_entity.dart';

abstract class LocationRepository {
  Future<Position> getCurrentLocation({LocationAccuracy accuracy});
  Future<LocationEntity> getLocationFromPlaceId(String query);
  Future<CameraPosition> getCameraPositionFromCurrentLocation(
      {double zoom = 14.0});
}