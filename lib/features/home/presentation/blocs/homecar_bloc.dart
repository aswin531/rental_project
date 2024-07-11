import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/home/domain/usecases/retrievecar_usecase.dart';
import 'package:rentit/features/home/presentation/blocs/homecar_event.dart';
import 'package:rentit/features/home/presentation/blocs/homecar_state.dart';

class HomeCarRetrieveBloc
    extends Bloc<HomeDisplayCarEvent, HomeDisplayCarState> {
  final RetrieveCars retrieveCars;

  HomeCarRetrieveBloc({required this.retrieveCars})
      : super(HomeDisplayCarLoading());

  Stream<HomeDisplayCarState> mapEventToState(
      HomeDisplayCarEvent homeDisplayCarEvent) async* {
    if (homeDisplayCarEvent is FetchCars) {
      yield HomeDisplayCarLoading();
      try {
        final cars = await retrieveCars();
        yield HomeDisplayCarLoaded(cars);
      } catch (e) {
        yield HomeDisplayCarError(message: e.toString());
      }
    }
  }
}
