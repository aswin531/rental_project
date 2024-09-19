import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/domain/entity/location_entity.dart';
import 'package:rentit/features/location/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository repository;
  GetCurrentLocationUseCase({required this.repository});

  Future<Position> call() async {
    return await repository.getCurrentLocation();
  }
}

class GetLocationFromPlaceIdUseCase {
  final LocationRepository locationRepository;
  GetLocationFromPlaceIdUseCase( this.locationRepository);

  Future<LocationEntity> call(String query) async {
    return await locationRepository.getLocationFromPlaceId(query);
  }
}

class GetCurrentLocationCameraPositionUseCase {
  final LocationRepository locationRepository;
  GetCurrentLocationCameraPositionUseCase(this.locationRepository);

  Future<CameraPosition> call({double zoom = 14.0}) async {
    return await locationRepository.getCameraPositionFromCurrentLocation(zoom: zoom);
  }
}