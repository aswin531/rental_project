import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';
import 'package:rentit/features/payments/domain/usecases/payment_usecases.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_event.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePaymentUsecase makePaymentUsecase;

  PaymentBloc({required this.makePaymentUsecase}) : super(PaymentInitial()) {
    on<MakePaymentEvent>(_onMakePayment);
  }

  Future<void> _onMakePayment(
      MakePaymentEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    final payment = Payment(amount: event.amount, currency: event.currency);
    final result = await makePaymentUsecase(payment);
    if (result) {
      emit(PaymentSuccess());
    } else {
      emit(PaymentFailure("Payment failed Or was cancelled"));
    }
  }
}
