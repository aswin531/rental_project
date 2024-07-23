import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetcarUsecase getcarUsecase;

  CarBloc({required this.getcarUsecase}) : super(CarInitial()) {
    on<FetchCars>(onFetchCars);
    on<RefreshCars>(onRefreshCars);
    on<FilterCars>(onFilterCars);
    on<FetchBrands>(onFetchBrands);
  }

//onFetch
  Future<void> onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = await getcarUsecase.execute();
      emit(CarLoaded(cars));
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }

//onRefresh
  Future<void> onRefreshCars(RefreshCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = await getcarUsecase.execute();
      emit(CarLoaded(cars));
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }

//onFilter
  Future<void> onFilterCars(FilterCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      final cars = await getcarUsecase.execute();
      final filteredBrands =
          cars.where((car) => car.make == event.brand).toList();
      emit(CarLoaded(filteredBrands));
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }

//filterBrand
  Future<void> onFetchBrands(FetchBrands event, Emitter<CarState> emit) async {
    try {
      final cars = await getcarUsecase.execute();
      final brands = cars.map((car) => car.make).toSet().toList();
      emit(BrandsLoaded(brands));
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }
}
