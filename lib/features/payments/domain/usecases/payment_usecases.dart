import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';
import 'package:rentit/features/payments/domain/repository/payment_repository.dart';

class MakePaymentUsecase {
  final PaymentRepository paymentRepository;
  MakePaymentUsecase(this.paymentRepository);

  Future<bool> call(Payment payment) async {
    final clientSecret = await paymentRepository.createPaymentIntent(payment);
    if (clientSecret == null) {
      return false;
    }
  
    return await paymentRepository.processPayment(clientSecret);
  }
}
