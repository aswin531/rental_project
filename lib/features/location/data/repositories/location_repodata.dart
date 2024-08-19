import 'package:rentit/features/location/data/datasources/location_datasource.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationRepository {
  Future<Position> getCurrentLocation();
  Future<Map<String, dynamic>> getSearchtLocation(String query);
}

class LocationRepositoryDataImpl implements LocationRepository {
  final LocationDatasource datasource;

  LocationRepositoryDataImpl({required this.datasource});

  @override
  Future<Position> getCurrentLocation() async {
    return await datasource.getCurrentLocation();
  }

  @override
  Future<Map<String, dynamic>> getSearchtLocation(String query) async {
    return await datasource.getSearchtLocation(query);
  }
}
