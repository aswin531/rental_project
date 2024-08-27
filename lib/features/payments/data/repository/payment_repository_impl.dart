import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';
import 'package:rentit/features/payments/domain/repository/payment_repository.dart';

class StripePaymentRepository implements PaymentRepository {
  final dio = GetIt.instance<Dio>();
  final String stripeSecretKey;
  StripePaymentRepository({required this.stripeSecretKey});

  @override
  Future<String?> createPaymentIntent(Payment payment) async {
    try {
      Map<String, dynamic> data = {
        "amount": (payment.amount * 100).toString(),
        "currency": payment.currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<bool> processPayment(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: 'Rent It'));
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
      return true;
    } catch (e) {
      if (e is StripeException) {
        if (e.error.code == FailureCode.Canceled) {
          debugPrint("Payment flow was canceled by the user.");
          return false;
        } else {
          debugPrint("Payment failed: ${e.error.localizedMessage}");
          return false;
        }
      } else {
        debugPrint("An unexpected error occurred: $e");
        return false;
      }
    }
  }
}
