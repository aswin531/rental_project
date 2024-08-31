import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';

class StripeServices {
  StripeServices._(); // Private Constructor

  static final StripeServices instance =
      StripeServices._(); //static instance of type StripeServices

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(100, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          // initialising PaymentSheet
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentClientSecret,
              merchantDisplayName: 'Rent It'));
      await _processPayment();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Payemnt Intent
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final dio = GetIt.instance<Dio>();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      //sending Request
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
        debugPrint(response.data.toString());
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      if (e is StripeException) {
        if (e.error.code == FailureCode.Canceled) {
          Text('Error : $e');
          debugPrint("Payment flow was canceled by the user.");
        } else {
          debugPrint("Payment failed: ${e.error.localizedMessage}");
        }
      } else {
        debugPrint("An unexpected error occurred: $e");
      }
      debugPrint(e.toString());
    }
  }
}

//$1 = 100