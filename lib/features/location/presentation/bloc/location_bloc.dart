import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rentit/features/location/domain/usecases/location_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationMapBloc extends Bloc<LocationEvent, LocationMapState> {
  final GetCurrentLocationCameraPositionUseCase
      _getCurrentLocationCameraPositionUseCase;
  GoogleMapController? _mapController;

  LocationMapBloc(this._getCurrentLocationCameraPositionUseCase)
      : super(LocationMapState(
            cameraPosition:
                const CameraPosition(target: LatLng(0, 0), zoom: 14))) {
    on<InitializeMap>(_onInitializeMap);
    on<MoveToCurrentLocation>(_onMoveToCurrentLocation);
  }

  Future<void> _onInitializeMap(
      InitializeMap event, Emitter<LocationMapState> emit) async {
    _mapController = event.googleMapController;
    debugPrint("Map initialized");
    add(MoveToCurrentLocation());
  }

  Future<void> _onMoveToCurrentLocation(
      MoveToCurrentLocation event, Emitter<LocationMapState> emit) async {
    try {
      final cameraPosition =
          await _getCurrentLocationCameraPositionUseCase.call();
      debugPrint(
          "Moving to: ${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}");

      if (_mapController != null) {
        await _mapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        debugPrint("Camera moved");
      } else {
        debugPrint("Map controller is null");
      }

      final address = await _getAddressFromLatLng(cameraPosition.target);
      debugPrint("Emitting new state with address: $address"); // Add this line

      emit(state.copyWith(
        cameraPosition: cameraPosition,
        currentAddress: address,
      ));
    } catch (e) {
      debugPrint("Error moving to current location: $e");
    }
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
      return "Address not found";
    } catch (e) {
      debugPrint("Error fetching address: $e");
      return "Error fetching address";
    }
  }
}
