import 'package:equatable/equatable.dart';

class CarReturnState extends Equatable {
  @override
  List<Object> get props => [];
}

class CarReturnInitial extends CarReturnState {}

class CarReturnInProgress extends CarReturnState {}

class CarReturnSuccess extends CarReturnState {}

class CarReturFailure extends CarReturnState {
  final String message;
  CarReturFailure(this.message);

  @override
  List<Object> get props => [message];
}
