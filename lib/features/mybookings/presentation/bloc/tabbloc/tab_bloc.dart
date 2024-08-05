import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/mybookings/presentation/bloc/events/tab_event.dart';
import 'package:rentit/features/mybookings/presentation/bloc/states/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0)) {
    on<BookingTabChanged>((event, emit) {
      emit(TabState(event.index));
    });
  }
}
