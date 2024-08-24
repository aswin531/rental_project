import 'package:equatable/equatable.dart';

abstract class RentalFormEvent extends Equatable {
  const RentalFormEvent();

  @override
  List<Object?> get props => [];
}

class UpdateName extends RentalFormEvent {
  final String name;

  const UpdateName(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdatePhone extends RentalFormEvent {
  final String phone;

  const UpdatePhone(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateEmail extends RentalFormEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdateAddress extends RentalFormEvent {
  final String address;

  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdateLicense extends RentalFormEvent {
  final String license;

  const UpdateLicense(this.license);

  @override
  List<Object?> get props => [license];
}

class UpdateComment extends RentalFormEvent {
  final String comment;

  const UpdateComment(this.comment);

  @override
  List<Object?> get props => [comment];
}

class UpdatePickUpLocation extends RentalFormEvent {
  final String pickUPlocation;

  const UpdatePickUpLocation(this.pickUPlocation);

  @override
  List<Object?> get props => [pickUPlocation];
}

class UpdateDropOffLocation extends RentalFormEvent {
  final String dropOffLocation;

  const UpdateDropOffLocation(this.dropOffLocation);

  @override
  List<Object?> get props => [dropOffLocation];
}


class SubmitForm extends RentalFormEvent {}