import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_event.dart';
import 'package:rentit/features/home/presentation/bloc/brand/brand_states.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final GetcarUsecase getcarUsecase;

  BrandsBloc({required this.getcarUsecase}) : super(BrandsInitial()) {
    on<FetchBrands>(onFetchBrands);
  }

  Future<void> onFetchBrands(FetchBrands event, Emitter<BrandsState> emit) async {
    emit(BrandsLoading());
    try {
      final cars = await getcarUsecase.execute();
      final brands = cars.map((car) => car.make).toSet().toList();
      if (brands.isNotEmpty) {
        emit(BrandsLoaded(brands));
      } else {
        emit(const BrandsError('No brands available'));
      }
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }
}
