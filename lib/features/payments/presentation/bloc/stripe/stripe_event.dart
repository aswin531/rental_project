import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object> get props => [];}

class MakePaymentEvent extends PaymentEvent {
  final int amount;
  final String currency;

  MakePaymentEvent({required this.amount, required this.currency});

  @override
  List<Object> get props => [amount, currency];
}
