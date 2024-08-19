import 'package:rentit/features/location/data/datasources/location_datasource.dart';
import 'package:rentit/features/location/data/models/location_model.dart';

abstract class LocationRepository {
  Future<LocationModel> getCurrentLocation();
  Future<LocationModel> getSearchtLocation(String query);
}

class LocationRepositoryDataImpl implements LocationRepository {
  final LocationDatasource datasource;

  LocationRepositoryDataImpl({required this.datasource});

  @override
  Future<LocationModel> getCurrentLocation() async {
    return await datasource.getCurrentLocation();
  }

  @override
  Future<LocationModel> getSearchtLocation(String query) async {
    return await datasource.getSearchtLocation(query);
  }
}
