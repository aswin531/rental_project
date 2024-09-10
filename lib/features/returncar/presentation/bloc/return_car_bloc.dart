import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_confirm_usecases.dart';
import 'package:rentit/features/returncar/domain/usecases/return_car_initial_usecases.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_event.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_state.dart';

class CarReturnBloc extends Bloc<CarReturnEvent, CarReturnState> {
  final ReturnCarInitialUsecases returnCarInitialUsecases;
  final ReturnCarConfirmUsecase returnCarConfirmUsecase;

  CarReturnBloc({
    required this.returnCarInitialUsecases,
    required this.returnCarConfirmUsecase,
  }) : super(CarReturnInitial()) {
    on<CarReturnInitiate>(_onCarReturnInitiate);
    on<CarReturnConfirmation>(_onCarReturnConfirmation);
  }

  Future<void> _onCarReturnInitiate(
      CarReturnInitiate event, Emitter<CarReturnState> emit) async {
    emit(CarReturnInProgress());
    try {
      await returnCarInitialUsecases.call(event.rentalId);
      emit(CarReturnSuccess());
    } catch (e) {
      emit(CarReturFailure(e.toString()));
    }
  }

  Future<void> _onCarReturnConfirmation(
      CarReturnConfirmation event, Emitter<CarReturnState> emit) async {
    emit(CarReturnInProgress());
    try {
      await returnCarConfirmUsecase.call(event.carReturnEntity);
      emit(CarReturnSuccess());
    } catch (e) {
      emit(CarReturFailure(e.toString()));
    }
  }
}
