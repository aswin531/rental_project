import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);

  @override
  List<Object> get props => [message];
} 
