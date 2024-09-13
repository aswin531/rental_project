import 'package:rentit/features/rental/data/model/combined.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';

abstract class RentalRequestState {
  final DateTime? startDate;
  final DateTime? returnDate;
  const RentalRequestState({this.startDate, this.returnDate});
}

class RentalRequestInitial extends RentalRequestState {
  RentalRequestInitial() : super();
}

class RentalRequestLoading extends RentalRequestState {
  RentalRequestLoading({super.startDate, super.returnDate});
}

class RentalRequestCreated extends RentalRequestState {}

class RentalRequestStatusUpdated extends RentalRequestState {}

class UserRentalRequestsLoaded extends RentalRequestState {
  final List<RentalRequest> requests;
  UserRentalRequestsLoaded(this.requests);
}

class RentalRequestError extends RentalRequestState {
  final String message;

  RentalRequestError(this.message, {super.startDate, super.returnDate});
}

class UserRentalRequestsWithCarDetailsLoaded extends RentalRequestState {
  final List<RentalRequestWithCarDetails> requestsWithCarDetails;

  UserRentalRequestsWithCarDetailsLoaded(this.requestsWithCarDetails);
}

class RentalRequestDateTimeState extends RentalRequestState {
  final DateTime? pickupDate;
  @override
  // ignore: overridden_fields
  final DateTime? returnDate;
  final DateTime? startTime;
  final DateTime? returnTime;
  final String? pickupLocation;
  final String? dropOffLocation;

  RentalRequestDateTimeState({
    this.pickupDate,
    this.returnDate,
    this.startTime,
    this.returnTime,
    this.pickupLocation,
    this.dropOffLocation,
  });
}

class ReturnProcessCompleted extends RentalRequestState {}

class CarAvailabilityChecked extends RentalRequestState {
  final bool isAvailable;

  CarAvailabilityChecked(
      {required this.isAvailable, super.startDate, super.returnDate});
}



class CarStatusUpdated extends RentalRequestState {
  final String status;

  CarStatusUpdated({required this.status});
}

