import 'package:rentit/features/rental/domain/entity/rental_entity.dart';

abstract class RentalRequestEvent {}

class CreateRentalRequestEvent extends RentalRequestEvent {
  final RentalRequest request;
  CreateRentalRequestEvent(this.request);
}

class FetchUserRentalRequestsEvent extends RentalRequestEvent {
  final String userId;
  FetchUserRentalRequestsEvent(this.userId);
}

class UpdateRentalRequestStatusEvent extends RentalRequestEvent {
  final String requestId;
  final String status;
  UpdateRentalRequestStatusEvent(this.requestId, this.status);
}

class FetchUserRentalRequestsWithCarDetailsEvent extends RentalRequestEvent {
  final String userId;
  FetchUserRentalRequestsWithCarDetailsEvent(this.userId);
}

// class UpdateStartDateTimeEvent extends RentalRequestEvent {
//   final DateTime pickupDateTime;
//   UpdateStartDateTimeEvent({required this.pickupDateTime});
// }

// Event for updating the start date================
class UpdateStartDateEvent extends RentalRequestEvent {
  final DateTime pickupDate;
  UpdateStartDateEvent({required this.pickupDate});
}

// Event for updating the start time=================
class UpdateStartTimeEvent extends RentalRequestEvent {
  final DateTime startTime;
  UpdateStartTimeEvent({required this.startTime});
}

// Event for updating the return date
class UpdateReturnDateEvent extends RentalRequestEvent {
  final DateTime returnDate;
  UpdateReturnDateEvent({required this.returnDate});
}

// Event for updating the return time
class UpdateReturnTimeEvent extends RentalRequestEvent {
  final DateTime returnTime;

  UpdateReturnTimeEvent({required this.returnTime});
}

class UpdatePickupLocationEvent extends RentalRequestEvent {
  final String pickupLocation;

  UpdatePickupLocationEvent(this.pickupLocation);
}

class UpdateDropOffLocationEvent extends RentalRequestEvent { 
  final String dropOffLocation;

  UpdateDropOffLocationEvent(this.dropOffLocation);
}

// class AcceptRentalRequestEvent extends RentalRequestEvent {
//   final String requestId;
//   final String carId;
//   final DateTime startDate;
//   final DateTime endDate;

//   AcceptRentalRequestEvent({
//     required this.requestId,
//     required this.carId,
//     required this.startDate,
//     required this.endDate,
//   });
// }

class CompleteReturnProcessEvent extends RentalRequestEvent {
  final String requestId;
  final String? carId;

  CompleteReturnProcessEvent({
    required this.requestId,
    this.carId,
  });
}

class CheckCarAvailabilityEvent extends RentalRequestEvent {
  final String carId;
  final DateTime startDate;
  final DateTime endDate;

  CheckCarAvailabilityEvent({required this.carId, required this.startDate, required this.endDate});
}

class UpdateCarStatusEvent extends RentalRequestEvent {
  final String carId;
  final String status;

  UpdateCarStatusEvent({required this.carId, required this.status});
}