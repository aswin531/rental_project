import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/carbybrand_usecase.dart';
import 'package:rentit/features/home/domain/usecases/getbrand_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_event.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_states.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final GetBrandUsecase getBrandUsecase;
  final GetCarsByBrandUsecase getCarsByBrandUsecase;

  BrandsBloc(
      {required this.getCarsByBrandUsecase, required this.getBrandUsecase})
      : super(BrandsInitial()) {
    on<FetchBrands>(onFetchBrands);
    on<FetchCarsByBrand>(onFetchCarsByBrand);
  }

  Future<void> onFetchBrands(
      FetchBrands event, Emitter<BrandsState> emit) async {
    emit(BrandsLoading());
    try {
      final brands = await getBrandUsecase.execute();
      emit(BrandsLoaded(brands));
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }

  Future<void> onFetchCarsByBrand(
      FetchCarsByBrand event, Emitter<BrandsState> emit) async {
    emit(BrandsLoading());
    try {
      final cars = await getCarsByBrandUsecase.execute(event.brandName);
      emit(CarsLoadedByBrand(cars));
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }
}
