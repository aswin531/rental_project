import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';

abstract class PaymentRepository {
  Future<String?> createPaymentIntent(Payment payment);
  Future<bool> processPayment(String clientSecret);
}