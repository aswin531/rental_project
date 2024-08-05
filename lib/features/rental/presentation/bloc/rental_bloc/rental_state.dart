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

// class CarDetailsLoaded extends RentalRequestState {
//   final Car car;
//   CarDetailsLoaded(this.car);
// }