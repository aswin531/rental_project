import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/getcar_usecase.dart';
import 'brand_event.dart';
import 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final GetcarUsecase getcarUsecase;

  BrandBloc({required this.getcarUsecase}) : super(BrandInitial()) {
    on<FetchBrands>(_onFetchBrands);
  }

  Future<void> _onFetchBrands(FetchBrands event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      final cars = await getcarUsecase.execute();
      final brands = cars.map((car) => car.make).toSet().toList();
      emit(BrandLoaded(brands));
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }
}
