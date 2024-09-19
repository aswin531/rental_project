import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentit/core/constants/constants.dart';
import 'package:rentit/features/location/data/models/location_model.dart';

abstract class LocationDatasource {
  Future<Position> getCurrentLocation({LocationAccuracy accuracy});
  Future<LocationModel> getSearchLocation(String query);
}

class LocationDataSourceImpl implements LocationDatasource {
  final Dio dio = Dio();
  final String googleApiKey = ApiServices().googleMapApiKey;
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
   Future<LocationModel> getSearchLocation(String query) async {
    const String url = 'https://nominatim.openstreetmap.org/search';
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'q': query,
          'format': 'json',
          'addressdetails': 1,
          'limit': 1,
        },
        options: Options(
          headers: {
            'User-Agent': 'rentit/1.0.0+1', 
          },
        ),
      );

      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        debugPrint("API data: $data");

        if (data.isNotEmpty) {
          final result = data[0];
          return LocationModel(
            latitude: double.parse(result['lat']),
            longitude: double.parse(result['lon']),
            address: result['display_name'],
          );
        } else {
          debugPrint('No results found');
          throw Exception('Location not found');
        }
      } else {
        throw Exception(
            'Failed to fetch location details, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching location: $e');
    }
  }
}

//===================================PLACES API=============================
  // Future<LocationModel> getSearchLocation(String placeId) async {
  //   const String url =
  //       'https://maps.googleapis.com/maps/api/place/details/json';
  //   try {
  //     debugPrint("GoogleAPIKEY : $googleApiKey");
  //     final response = await dio.get(
  //       url,
  //       queryParameters: {
  //         'place_id': placeId,
  //         'key': googleApiKey,
  //       },
  //     );
  //    // debugPrint("Searching location with placeId: $placeId");
  // debugPrint("Response status code: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //           debugPrint("API data: $data");

  //       if (data['status'] == 'OK' && data['result'] != null) {
  //         final result = data['result'];
  //         final location = result['geometry']['location'];
  //         final address = result['formatted_address'];

  //         return LocationModel(
  //           latitude: location['lat'],
  //           longitude: location['lng'],
  //           address: address,
  //         );
  //       } else {
  //         debugPrint('Error from API: ${data['status']}');
  //         throw Exception('Location details not found');
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to fetch location details, Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching location: $e');
  //   }
  // }

