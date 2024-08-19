import 'package:rentit/features/location/data/models/location_model.dart';

abstract class LocationDatasource {
  Future<LocationModel> getCurrentLocation();
  Future<LocationModel> getSearchtLocation(String query);
}

class LocationDataSourceImpl implements LocationDatasource {
  @override
  Future<LocationModel> getCurrentLocation() async {}

  @override
  Future<LocationModel> getSearchtLocation(String query) async {}
}
