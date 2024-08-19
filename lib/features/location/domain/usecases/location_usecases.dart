import 'package:rentit/features/location/domain/entity/location_entity.dart';
import 'package:rentit/features/location/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository repository;
  GetCurrentLocationUseCase({required this.repository});

  Future<LocationEntity> call() async {
    return await repository.getCurrentLocation();
  }
}

class GetSearchLocation {
  final LocationRepository repository;
  GetSearchLocation({required this.repository});

  Future<LocationEntity> call(String query) async {
    return await repository.getSearchLocation(query);
  }
}
