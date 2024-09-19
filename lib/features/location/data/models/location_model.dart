import 'package:rentit/features/location/domain/entity/location_entity.dart';
import 'package:googleapis/airquality/v1.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel(
      {required this.latitude, required this.longitude, required this.address});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        latitude: json['latitude'],
        longitude: json['longitude'],
        address: json['address']);
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': 'latitude',
      'longitude': 'longitude',
      'address': 'address'
    };
  }

   LocationEntity toEntity() {
    return LocationEntity(
      coordinates: LatLng(latitude: latitude, longitude: longitude),
      address: address
    );
  }
}