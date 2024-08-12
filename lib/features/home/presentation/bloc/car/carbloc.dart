import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetcarUsecase getcarUsecase;

  CarBloc({required this.getcarUsecase}) : super(CarInitial()) {
    on<FetchCars>(onFetchCars);
    on<RefreshCars>(onRefreshCars);
    //on<FilterCars>(onFilterCars);
    // on<FetchBrands>(onFetchBrands);
  }

  Future<void> onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = await getcarUsecase.execute();
      emit(CarLoaded(cars));
    } catch (e) {
      debugPrint("Error in onFetchCars: $e");
      emit(CarError(e.toString()));
    }
  }

  Future<void> onRefreshCars(RefreshCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = await getcarUsecase.execute();
      emit(CarLoaded(cars));
    } catch (e) {
      debugPrint("Error in onRefreshCars: $e");
      emit(CarError(e.toString()));
    }
  }

  // Future<void> onFilterCars(FilterCars event, Emitter<CarState> emit) async {
  //   emit(BrandLoading());
  //   try {
  //     final cars = await getcarUsecase.execute();
  //     final filteredBrands =
  //         cars.where((car) => car.make == event.brand).toList();
  //     emit(CarLoaded(filteredBrands));
  //   } catch (e) {
  //     debugPrint("Error in onFilterCars: $e");
  //     emit(CarError(e.toString()));
  //   }
  // }

  // Future<void> onFetchBrands(FetchBrands event, Emitter<CarState> emit) async {
  //   debugPrint("onFetchBrands called");
  //  // emit(CarLoading());
  //   try {
  //     final cars = await getcarUsecase.execute();
  //     final brands = cars.map((car) => car.make).toSet().toList();
  //     debugPrint("Fetched brands: $brands");
  //     if (brands.isNotEmpty) {
  //       emit(BrandsLoaded(brands));
  //     } else {
  //       emit(const CarError('No brands available'));
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching brands: $e");
  //     emit(CarError(e.toString()));
  //   }
  // }
}
