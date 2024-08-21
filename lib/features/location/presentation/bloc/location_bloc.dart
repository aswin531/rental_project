import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/location/domain/usecases/location_usecases.dart';
import 'package:rentit/features/location/presentation/bloc/location_event.dart';
import 'package:rentit/features/location/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetSearchLocationUseCase getSearchLocationUseCase;

  LocationBloc(
      {required this.getCurrentLocationUseCase,
      required this.getSearchLocationUseCase})
      : super(LocationInitial()) {
    on<GetCurrentLocationEvent>(onGetCurrentLocation);
    on<SearchLocationEvent>(onGetSearchLocation);
  }

  Future<void> onGetCurrentLocation(
      GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final position = await getCurrentLocationUseCase.call();
      emit(LocationLoaded(position));
    } catch (e) {
      debugPrint("Error in onGetCurrentLocation: $e");
      emit(LocationError(message: e.toString()));
    }
  }

  Future<void> onGetSearchLocation(
      SearchLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final searchResult = await getSearchLocationUseCase.call(event.query);
      emit(SearchLocationLoaded(searchResult));
    } catch (e) {
      debugPrint("Error in onGetsearchLocation: $e");
      emit(LocationError(message: e.toString()));
    }
  }
}
