import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/mybooking_bloc/event.dart';
import 'package:rentit/features/rental/presentation/bloc/mybooking_bloc/state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0)) {
    on<BookingTabChanged>((event, emit) {
      emit(TabState(event.index));
    });
  }
}