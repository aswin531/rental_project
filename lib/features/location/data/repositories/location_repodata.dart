
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/data/datasources/location_datasource.dart';
import 'package:rentit/features/location/domain/entity/location_entity.dart';
import 'package:rentit/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource locationDatasource;
  LocationRepositoryImpl(this.locationDatasource);

  @override
  Future<Position> getCurrentLocation(
      {LocationAccuracy accuracy = LocationAccuracy.bestForNavigation}) async {
    return await locationDatasource.getCurrentLocation(accuracy: accuracy);
  }

  @override
  Future<CameraPosition> getCameraPositionFromCurrentLocation(
      {double zoom = 14.0}) async {
    final position = await getCurrentLocation();
    return CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: zoom);
  }

  @override
  Future<LocationEntity> getLocationFromPlaceId(String query) {
    throw UnimplementedError();
  }
}
