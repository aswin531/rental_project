import 'package:googleapis/authorizedbuyersmarketplace/v1.dart';
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
//   final DateTime startDateTime;
//   UpdateStartDateTimeEvent({required this.startDateTime});
// }

// Event for updating the start date================
class UpdateStartDateEvent extends RentalRequestEvent {
  final DateTime startDate;
  UpdateStartDateEvent({required this.startDate});
}

// Event for updating the start time=================
class UpdateStartTimeEvent extends RentalRequestEvent {
  final TimeOfDay startTime;
  UpdateStartTimeEvent({required this.startTime});
}

// Event for updating the return date
class UpdateReturnDateEvent extends RentalRequestEvent {
  final DateTime returnDate;
  UpdateReturnDateEvent({required this.returnDate});
}

// Event for updating the return time
class UpdateReturnTimeEvent extends RentalRequestEvent {
  final TimeOfDay returnTime;
  UpdateReturnTimeEvent({required this.returnTime});
}
