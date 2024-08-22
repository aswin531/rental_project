import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentit/features/location/domain/usecases/location_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationMapBloc extends Bloc<LocationEvent, LocationMapState> {
  final GetCurrentLocationCameraPositionUseCase
      _getCurrentLocationCameraPositionUseCase;

  LocationMapBloc(this._getCurrentLocationCameraPositionUseCase)
      : super(LocationMapState(
            cameraPosition:
                const CameraPosition(target: LatLng(0, 0), zoom: 14))) {
    on<InitializeMap>(_onInitializeMap);
    on<MoveToCurrentLocation>(_onMoveToCurrentLocation);
  }

  Future<void> _onInitializeMap(
      InitializeMap event, Emitter<LocationMapState> emit) async {
    emit(state.copyWith(mapController: event.googleMapController));
    add(MoveToCurrentLocation());
  }

  Future<void> _onMoveToCurrentLocation(
      MoveToCurrentLocation event, Emitter<LocationMapState> emit) async {
    try {
      final cameraPosition =
          await _getCurrentLocationCameraPositionUseCase.call();
      emit(state.copyWith(cameraPosition: cameraPosition));
      await state.mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
