import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationEvent {}

//=GoogleMapController===control the map==when the map is initialized

class InitializeMap extends LocationEvent {
  final GoogleMapController googleMapController;
  InitializeMap(this.googleMapController);
}

//move the camera to the user's current location=============
class MoveToCurrentLocation extends LocationEvent{}