import 'package:geolocator/geolocator.dart';
import 'package:rentit/features/location/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository repository;
  GetCurrentLocationUseCase({required this.repository});

  Future<Position> call() async {
    return await repository.getCurrentLocation();
  }
}

class GetSearchLocationUseCase {
  final LocationRepository repository;
  GetSearchLocationUseCase({required this.repository});

  Future<Map<String, dynamic>> call(String query) async {
    return await repository.getSearchLocation(query);
  }
}
