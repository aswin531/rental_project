import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationDatasource {
  Future<Position> getCurrentLocation({LocationAccuracy accuracy});
  Future<Map<String, dynamic>> getSearchtLocation(String query);
}

class LocationDataSourceImpl implements LocationDatasource {
  final Dio dio = Dio();
  final String googleApiKey = "googleAPIKey";
  @override
  //===Position class designed to hold =>latitude,longitude,timestamp,accuracy,altitude,speed,heading
  Future<Position> getCurrentLocation(
      {LocationAccuracy accuracy = LocationAccuracy.bestForNavigation}) async {
    bool serviceEnabled;
    LocationPermission permission;
//=========  Checking location services are enabled===================
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location Services are Disabled');
    }
//===check permission that we can access the location if location is enabled====
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

//============= we have the permissions=========================
    final position =
        await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
    debugPrint("Current location: ${position.latitude}, ${position.longitude}");
    return position;
  }

  @override
  Future<Map<String, dynamic>> getSearchtLocation(String query) async {
    const String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json';
    try {
      final response = await dio.get(
        url,
        queryParameters: {'query': query, 'key': googleApiKey},
      );
      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          final location = results[0]['geometry']['location'];
          return {
            'lat': location['lat'],
            'lng': location['lng'],
            'name': results[0]['name'],
          };
        }
      }
      throw Exception('Location not found');
    } catch (e) {
      throw Exception('Error Searching for location : $e');
    }
  }

  // @override
  // Future<LocationModel> getSearchtLocation(String query) async {

  // }
}
