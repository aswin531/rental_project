import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_event.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';

class SelectedCarBloc extends Bloc<SelectedCarEvent, SelectedCarState> {
  SelectedCarBloc() : super(SelectedCarInitial()) {
    on<SelectCar>((event, emit) {
      emit(CarSelected(event.selectedCar));
    });
  }
}
