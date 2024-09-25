import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/domain/repositories/auth_repository.dart';
import 'package:rentit/features/rental/domain/repository/rental_repo.dart';
import 'package:rentit/features/rental/domain/usecases/get_user_rental.dart';
import 'package:rentit/features/rental/domain/usecases/rental_car_return_completion.dart';
import 'package:rentit/features/rental/domain/usecases/update_car_availability_usecase.dart';
import 'package:rentit/features/rental/domain/usecases/update_request.dart';
import 'package:rentit/features/rental/domain/usecases/rental_usecase.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';

import '../../../data/model/combined.dart';

class RentalRequestBloc extends Bloc<RentalRequestEvent, RentalRequestState> {
  final RentalRequestRepository rentalRequestRepository;
  DateTime? pickupDate;
  DateTime? returnDate;
  DateTime? startTime;
  DateTime? returnTime;

  final CreateRentalRequest createRentalRequest;
  final GetUserRentalRequests getUserRentalRequests;
  final UpdateRentalRequestStatus updateRentalRequestStatus;
  final UpdateCarAvailabilityUsecase updateCarAvailabilityUsecase;
  final CompleteReturnProcessUsecase completeReturnProcessUsecase;

  final AuthRepository? authRepository;

  RentalRequestBloc(
      {required this.createRentalRequest,
      required this.getUserRentalRequests,
      required this.updateRentalRequestStatus,
      required this.updateCarAvailabilityUsecase,
      required this.completeReturnProcessUsecase,
      required this.rentalRequestRepository,
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
    //on<FetchCompletedRentalRequestsEvent>(_onFetchCompletedRentalRequestsEvent);
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

  void _onFetchUserRentalRequestsWithCarDetails(
    FetchUserRentalRequestsWithCarDetailsEvent event,
    Emitter<RentalRequestState> emit,
  ) async {
    emit(RentalRequestLoading());
    await emit.forEach(
      getUserRentalRequests(event.userId),
      onData: (List<RentalRequestWithCarDetails> requestsWithCarDetails) {
        if (requestsWithCarDetails.isNotEmpty) {
          debugPrint('Data passed to UI: ${requestsWithCarDetails.length}');
          return UserRentalRequestsWithCarDetailsLoaded(requestsWithCarDetails);
        } else {
          debugPrint('No data found');
          return UserRentalRequestsWithCarDetailsLoaded([]);
        }
      },
      onError: (error, stackTrace) {
        debugPrint('Error: $error');
        return RentalRequestError(error.toString());
      },
    );
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
    pickupDate = event.pickupDate;
    emit(RentalRequestDateTimeState(
      pickupDate: pickupDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime,
    ));
  }

  void _onUpdateStartTime(
    UpdateStartTimeEvent event,
    Emitter<RentalRequestState> emit,
  ) {
    startTime = event.startTime;
    emit(RentalRequestDateTimeState(
      pickupDate: pickupDate,
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
      pickupDate: pickupDate,
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
      pickupDate: pickupDate,
      startTime: startTime,
      returnDate: returnDate,
      returnTime: returnTime,
    ));
  }
}
