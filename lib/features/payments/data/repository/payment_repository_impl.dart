import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rentit/features/payments/data/datasources/stripe_datasource.dart';
import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';
import 'package:rentit/features/payments/domain/repository/payment_repository.dart';

class StripePaymentRepository implements PaymentRepository {
  final dio = GetIt.instance<Dio>();
  final String stripeSecretKey;
  final PaymentDataSource paymentDataSource;
  StripePaymentRepository({required this.stripeSecretKey,required this.paymentDataSource});

  @override
  Future<String?> createPaymentIntent(Payment payment) async {
    return await paymentDataSource.createPaymentIntent(payment);
  }

  @override
  Future<bool> processPayment(String clientSecret) async {
    return await paymentDataSource.processPayment(clientSecret);
  }
 

  Future<bool> updatePaymentStatus(BuildContext context, String docId) async {
    try {
      await paymentDataSource.updatePaymentStatus(docId);
      return true;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update payment status: $e')),
      );
      return false;
    }
  }
}
