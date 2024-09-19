import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rentit/features/location/data/models/location_model.dart';
import 'package:rentit/features/location/domain/entity/location_entity.dart';
import 'package:rentit/features/location/domain/usecases/location_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';
import 'package:rentit/utils/debouncer.dart';

class LocationMapBloc extends Bloc<LocationEvent, LocationMapState> {
  final GetCurrentLocationCameraPositionUseCase
      _getCurrentLocationCameraPositionUseCase;

  final GetLocationFromPlaceIdUseCase getLocationFromPlaceIdUseCase;
  GoogleMapController? _mapController;
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(milliSeconds: 500);

  LocationMapBloc(this._getCurrentLocationCameraPositionUseCase,
      this.getLocationFromPlaceIdUseCase)
      : super(LocationMapState(
            cameraPosition:
                const CameraPosition(target: LatLng(0, 0), zoom: 14))) {
    on<InitializeMap>(_onInitializeMap);
    on<MoveToCurrentLocation>(_onMoveToCurrentLocation);
    on<SearchLocationEvent>(_onSearchLocation);
    on<UpdatePickupLocationEvent>(_onUpdatePickupLocation);
    on<UpdateDropOffLocationEvent>(_onUpdateDropOffLocation);
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
      debugPrint("Emitting new state with address: $address");

      emit(state.copyWith(
        cameraPosition: cameraPosition,
        currentAddress: address,
      ));
    } catch (e) {
      debugPrint("Error moving to current location: $e");
    }
  }

  Future<void> _onSearchLocation(
      SearchLocationEvent event, Emitter<LocationMapState> emit) async {
    try {
      final LocationEntity result =
          await getLocationFromPlaceIdUseCase.call(event.query);

      final LocationModel locationModel = LocationModel(
        latitude: result.coordinates.latitude!,
        longitude: result.coordinates.longitude!,
        address: result.address,
      );
      final newCameraPosition = CameraPosition(
        target: LatLng(locationModel.latitude, locationModel.longitude),
        zoom: 14,
      );

      if (_mapController != null) {
        await _mapController!
            .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      }

      emit(state.copyWith(
        cameraPosition: newCameraPosition,
        currentAddress: result.address,
        searchResults: [locationModel],
      ));
        } catch (e) {
      debugPrint("Error searching location: $e");
      // emit(state.copyWith(searchResults: ['Error occurred while searching']));
    }
  }

  void _onUpdatePickupLocation(
      UpdatePickupLocationEvent event, Emitter<LocationMapState> emit) {
    emit(state.copyWith(pickupLocation: event.location.address));
  }

  void _onUpdateDropOffLocation(
      UpdateDropOffLocationEvent event, Emitter<LocationMapState> emit) {
    emit(state.copyWith(dropOffLocation: event.location.address));
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
