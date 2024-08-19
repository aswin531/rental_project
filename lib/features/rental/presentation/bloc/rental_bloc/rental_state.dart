import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';

abstract class RentalRequestState {}

class RentalRequestInitial extends RentalRequestState {}

class RentalRequestLoading extends RentalRequestState {}

class RentalRequestCreated extends RentalRequestState {}

class RentalRequestStatusUpdated extends RentalRequestState {}

class UserRentalRequestsLoaded extends RentalRequestState {
  final List<RentalRequest> requests;
  UserRentalRequestsLoaded(this.requests);
}

class RentalRequestError extends RentalRequestState {
  final String message;
  RentalRequestError(this.message);
}

class UserRentalRequestsWithCarDetailsLoaded extends RentalRequestState {
  final List<RentalRequestWithCarDetails> requestsWithCarDetails;

  UserRentalRequestsWithCarDetailsLoaded(this.requestsWithCarDetails);
}

// class RentalRequestDateTimeUpdated extends RentalRequestState {}

class RentalRequestDateTimeState extends RentalRequestState {
  final DateTime? startDate;
  final DateTime? startTime;
  final DateTime? returnDate;
  final DateTime? returnTime;

  RentalRequestDateTimeState({
    this.startDate,
    this.startTime,
    this.returnDate,
    this.returnTime,
  });
}
