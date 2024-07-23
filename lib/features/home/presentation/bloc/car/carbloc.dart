import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/car/carevent.dart';
import 'package:rentit/features/home/presentation/bloc/car/carstates.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetcarUsecase getcarUsecase;

  CarBloc({required this.getcarUsecase}) : super(CarInitial()) {
    on<FetchCars>(onFetchCars);
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
      final filteredCars =
          cars.where((car) => car.make == event.brand).toList();
      emit(CarLoaded(filteredCars));
    } catch (e) {
      emit(CarError(e.toString()));
    }
  }
}
