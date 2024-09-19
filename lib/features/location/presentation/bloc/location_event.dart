import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/data/models/location_model.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}
//=GoogleMapController===control the map==when the map is initialized

class InitializeMap extends LocationEvent {
  final GoogleMapController googleMapController;
  const InitializeMap(this.googleMapController);
}

//move the camera to the user's current location=============
class MoveToCurrentLocation extends LocationEvent {}

class LoadPageEvent extends LocationEvent {}

class SearchLocationEvent extends LocationEvent {
  final String query;

  const SearchLocationEvent({required this.query});
}

class UpdatePickupLocationEvent extends LocationEvent {
  final LocationModel location;
  const UpdatePickupLocationEvent(this.location);
  @override
  List<Object?> get props => [location];
}

class UpdateDropOffLocationEvent extends LocationEvent {
  final LocationModel location;
  const UpdateDropOffLocationEvent(this.location);
  @override
  List<Object?> get props => [location];
}

class UseCurrentLocationForPickup extends LocationEvent {
  const UseCurrentLocationForPickup();
}

class UseCurrentLocationForDropOff extends LocationEvent {
  const UseCurrentLocationForDropOff();
}

class UseCurrentLocationForBoth extends LocationEvent {
  const UseCurrentLocationForBoth();
}
