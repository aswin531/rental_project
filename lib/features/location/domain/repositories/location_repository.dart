import 'package:rentit/features/location/domain/entity/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
  Future<LocationEntity> getSearchLocation(String query);
}
