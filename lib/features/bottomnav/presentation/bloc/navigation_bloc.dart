import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/bottomnav/presentation/bloc/navigation_event.dart';
import 'package:rentit/features/bottomnav/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(TabChanged(0));

  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ChangeTab) {
      yield TabChanged(event.index);
    }
  }
}
