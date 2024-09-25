// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/domain/usecases/search_filter_usecases.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCarsStreamUseCase getCarsStreamUseCase;
    final SearchCarsUsecase searchCarsUsecase;
  final FilterCarsUsecase filterCarsUsecase;


//==========Constructor DI===========================
  CarBloc({required this.getCarsStreamUseCase, required this.searchCarsUsecase,
    required this.filterCarsUsecase,}) : super(CarInitial()) {
//============EVENT HANDER=========================
    on<FetchCars>(onFetchCars);
    on<RefreshCars>(onRefreshCars);
    on<SearchCars>(_onSearchCars);
    on<FilterCars>(_onFilterCars);
  }

  onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = getCarsStreamUseCase();
      await emit.forEach<List<CarVehicleEntity>>(
        cars,
        onData: (cars) => CarLoaded(cars),
        onError: (error, stackTrace) => CarError(error.toString()),
      );
    } catch (e) {
      debugPrint("Error in onFetchCars: $e");
      emit(CarError(e.toString()));
    }
  }

  onRefreshCars(RefreshCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = getCarsStreamUseCase();
      await emit.forEach<List<CarVehicleEntity>>(
        cars,
        onData: (cars) => CarLoaded(cars),
        onError: (error, stackTrace) => CarError(error.toString()),
      );
    } catch (e) {
      debugPrint("Error in onRefreshCars: $e");
      emit(CarError(e.toString()));
    }
  }
 
 void _onSearchCars(SearchCars event, Emitter<CarState> emit) async {
  print('Searching for cars with term: ${event.searchTerm}');
  emit(CarLoading());
  try {
    await emit.forEach(
      searchCarsUsecase.call(event.searchTerm),
      onData: (List<CarVehicleModel> cars) {
        print('Cars found: ${cars.length}');
        return CarSearchLoaded(cars);
      },
      onError: (error, stackTrace) {
        print('Search error: $error');
        return CarError(error.toString());
      },
    );
  } catch (e) {
    print('Exception during search: $e');
    emit(CarError(e.toString()));
  }
}


  void _onFilterCars(FilterCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      await emit.forEach(
        filterCarsUsecase.call(
          make: event.make,
          model: event.model,
         // priceRange: event.priceRange,
          year: event.year,
        ),
        onData: (List<CarVehicleModel> cars) => CarSearchLoaded(cars),
        onError: (error, stackTrace) => CarError( error.toString()),
      );
    } catch (e) {
      emit(CarError( e.toString()));
    }
  }
}
