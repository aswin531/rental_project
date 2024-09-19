import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/data/models/location_model.dart';

class LocationMapState extends Equatable {
  final CameraPosition cameraPosition; // latitude, longitude
  final GoogleMapController? mapController; //Map Controller
  final String? currentAddress;
  final String? pickupLocation;
  final String? dropOffLocation;
  final List<LocationModel> searchResults;

  const LocationMapState({
    required this.cameraPosition,
    this.mapController,
    this.currentAddress,
    this.pickupLocation,
    this.dropOffLocation,
    this.searchResults = const [],
  });

  LocationMapState copyWith({
    CameraPosition? cameraPosition,
    GoogleMapController? mapController,
    String? currentAddress,
    String? pickupLocation,
    String? dropOffLocation,
    List<LocationModel>? searchResults,
  }) {
    return LocationMapState(
      cameraPosition: cameraPosition ?? this.cameraPosition,
      mapController: mapController ?? this.mapController,
      currentAddress: currentAddress ?? this.currentAddress,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropOffLocation: dropOffLocation ?? this.dropOffLocation,
      searchResults: searchResults ?? this.searchResults,
    );
  }
  
  @override
  List<Object?> get props => [
    cameraPosition,
    mapController,
    currentAddress,
    pickupLocation,
    dropOffLocation,
    searchResults,
  ];
}
