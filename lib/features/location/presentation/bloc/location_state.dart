import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationMapState extends LocationState {
  final CameraPosition cameraPosition; //====current camera position on the map
  final GoogleMapController? mapController; //===TO Interact with MAP

  LocationMapState({required this.cameraPosition, this.mapController});
//object is created whenever the state changes
  LocationMapState copyWith({
    CameraPosition? cameraPosition,
    GoogleMapController? mapController,
  }) {
    return LocationMapState(
        cameraPosition: cameraPosition ?? this.cameraPosition,
        mapController: mapController ?? this.mapController);
  }
}

class LocationError extends LocationState {
  final String message;

  LocationError({required this.message});
}
