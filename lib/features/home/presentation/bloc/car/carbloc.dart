import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCarsStreamUseCase getCarsStreamUseCase;

//==========Constructor DI===========================
  CarBloc({required this.getCarsStreamUseCase}) : super(CarInitial()) {
//============EVENT HANDER=========================
    on<FetchCars>(onFetchCars);
    on<RefreshCars>(onRefreshCars);
  }

  Future<void> onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = getCarsStreamUseCase.execute();
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

  Future<void> onRefreshCars(RefreshCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = getCarsStreamUseCase.execute();
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
}
