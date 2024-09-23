import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rentit/core/constants/constants.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/payments/domain/enitity/payment_entity.dart';
import 'package:dio/dio.dart';

class PaymentDataSource {

  PaymentDataSource();

  
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

//showing sheets
  Future<bool> processPayment(String clientSecret) async {
  try {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'Rent It'));
    await Stripe.instance.presentPaymentSheet();
    return true; // This assumes the payment was successful
  } catch (e) {
    if (e is StripeException) {
      debugPrint("Payment failed: ${e.error.localizedMessage}");
      return false;
    } else {
      debugPrint("An unexpected error occurred: $e");
      return false;
    }
  }
}


  Future<bool> updatePaymentStatus(String docId) async {
    try {
      await firebaseFirestore.collection('rental_requests').doc(docId).update({
        'paymentStatus': 'completed',
      });
      debugPrint('Payment status updated successfully for document: $docId');
      return true;
    } catch (e) {
      debugPrint('Error updating payment status: $e');
      return false;
    }
  }
}
