import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/rental/domain/usecases/get_user_rental.dart';
import 'package:rentit/features/rental/domain/usecases/update_request.dart';
import 'package:rentit/features/rental/domain/usecases/rental_usecase.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

class RentalRequestBloc extends Bloc<RentalRequestEvent, RentalRequestState> {
  final CreateRentalRequest createRentalRequest;
  final GetUserRentalRequests getUserRentalRequests;
  final UpdateRentalRequestStatus updateRentalRequestStatus;
    final AuthRepository? authRepository;


  RentalRequestBloc({
    required this.createRentalRequest,
    required this.getUserRentalRequests,
    required this.updateRentalRequestStatus,
     this.authRepository
  }) : super(RentalRequestInitial()) {
    on<CreateRentalRequestEvent>(_onCreateRentalRequest);
    on<FetchUserRentalRequestsEvent>(_onFetchUserRentalRequests);
    on<UpdateRentalRequestStatusEvent>(_onUpdateRentalRequestStatus);
  }

  Future<void> _onCreateRentalRequest(
    CreateRentalRequestEvent event,
    Emitter<RentalRequestState> emit,
  ) async {
    emit(RentalRequestLoading());
    try {
      await createRentalRequest(event.request);
      emit(RentalRequestCreated());
    } catch (e) {
      emit(RentalRequestError(e.toString()));
    }
  }

Future<void> _onFetchUserRentalRequests(
  FetchUserRentalRequestsEvent event,
  Emitter<RentalRequestState> emit,
) async {
  emit(RentalRequestLoading());
  try {
    final requests = await getUserRentalRequests(event.userId);
    emit(UserRentalRequestsLoaded(requests));
  } catch (e) {
    emit(RentalRequestError(e.toString()));
  }
}


  Future<void> _onUpdateRentalRequestStatus(
    UpdateRentalRequestStatusEvent event,
    Emitter<RentalRequestState> emit,
  ) async {
    emit(RentalRequestLoading());
    try {
      await updateRentalRequestStatus(event.requestId, event.status);
      emit(RentalRequestStatusUpdated());
    } catch (e) {
      emit(RentalRequestError(e.toString()));
    }
  }
}