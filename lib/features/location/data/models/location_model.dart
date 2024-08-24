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
}