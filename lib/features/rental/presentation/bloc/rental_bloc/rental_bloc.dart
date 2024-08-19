import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/rental/domain/usecases/get_user_rental.dart';
import 'package:rentit/features/rental/domain/usecases/update_request.dart';
import 'package:rentit/features/rental/domain/usecases/rental_usecase.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

class RentalRequestBloc extends Bloc<RentalRequestEvent, RentalRequestState> {
  DateTime? startDate;
  DateTime? returnDate;
  DateTime? startTime;
  DateTime? returnTime;

  final CreateRentalRequest createRentalRequest;
  final GetUserRentalRequests getUserRentalRequests;
  final UpdateRentalRequestStatus updateRentalRequestStatus;
  final AuthRepository? authRepository;
  //final GetCarDetails getCarDetails;

  RentalRequestBloc(
      {required this.createRentalRequest,
      required this.getUserRentalRequests,
      required this.updateRentalRequestStatus,
      this.authRepository})
      : super(RentalRequestInitial()) {
    on<CreateRentalRequestEvent>(_onCreateRentalRequest);
    on<FetchUserRentalRequestsWithCarDetailsEvent>(
        _onFetchUserRentalRequestsWithCarDetails);
    on<UpdateRentalRequestStatusEvent>(_onUpdateRentalRequestStatus);
    on<UpdateStartDateEvent>(_onUpdateStartDate);
    on<UpdateStartTimeEvent>(_onUpdateStartTime);
    on<UpdateReturnDateEvent>(_onUpdateReturnDate);
    on<UpdateReturnTimeEvent>(_onUpdateReturnTime);
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

  Future<void> _onFetchUserRentalRequestsWithCarDetails(
    FetchUserRentalRequestsWithCarDetailsEvent event,
    Emitter<RentalRequestState> emit,
  ) async {
    emit(RentalRequestLoading());
    try {
      final requestsWithCarDetails = await getUserRentalRequests(event.userId);
      emit(UserRentalRequestsWithCarDetailsLoaded(requestsWithCarDetails));
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

  void _onUpdateStartDate(
    UpdateStartDateEvent event,
    Emitter<RentalRequestState> emit,
  ) {
    startDate = event.startDate;
    emit(RentalRequestDateTimeState(
      startDate: startDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime ,
    ));
  }

  void _onUpdateStartTime(
    UpdateStartTimeEvent event,
    Emitter<RentalRequestState> emit,
  ) {
    startTime = event.startTime;
    emit(RentalRequestDateTimeState(
      startDate: startDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime,
    ));
  }

  void _onUpdateReturnDate(
    UpdateReturnDateEvent event,
    Emitter<RentalRequestState> emit,
  ) {
    returnDate = event.returnDate;
    emit(RentalRequestDateTimeState(
      startDate: startDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime,
    ));
  }

  void _onUpdateReturnTime(
    UpdateReturnTimeEvent event,
    Emitter<RentalRequestState> emit,
  ) {
    returnTime = event.returnTime;
    emit(RentalRequestDateTimeState(
      startDate: startDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime,
    ));
  }
}
