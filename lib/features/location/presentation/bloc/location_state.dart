import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapState {
  final CameraPosition cameraPosition;
  final GoogleMapController? mapController;
  final String? currentAddress;

  LocationMapState({
    required this.cameraPosition,
    this.mapController,
    this.currentAddress,
  });

  LocationMapState copyWith({
    CameraPosition? cameraPosition,
    GoogleMapController? mapController,
    String? currentAddress,
  }) {
    return LocationMapState(
      cameraPosition: cameraPosition ?? this.cameraPosition,
      mapController: mapController ?? this.mapController,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }
}