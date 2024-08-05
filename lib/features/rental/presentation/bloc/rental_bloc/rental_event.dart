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




