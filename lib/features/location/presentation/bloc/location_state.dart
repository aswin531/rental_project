import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position location;

  LocationLoaded(this.location);
}

class SearchLocationLoaded extends LocationState {
  final Map<String, dynamic> searchResult;

  SearchLocationLoaded(this.searchResult);
}

class LocationError extends LocationState {
  final String message;

  LocationError({required this.message});
}
