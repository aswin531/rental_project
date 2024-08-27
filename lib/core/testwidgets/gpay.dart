import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePayButtonWidget extends StatelessWidget {
  final String amount;
  final String currency;

  const GooglePayButtonWidget(
      {super.key, required this.amount, required this.currency});

  void onGooglePayResult(paymentResult) {
    // Handle the payment result
    debugPrint(paymentResult);
  }

 Future<PaymentConfiguration> loadPaymentConfiguration() async {
  try {
    return await PaymentConfiguration.fromAsset('assets/google_pay_payment_profile.json');
  } catch (e) {
    debugPrint('Error loading payment configuration: $e');
    rethrow;
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: loadPaymentConfiguration(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final paymentItems = [
            PaymentItem(
              label: 'Total',
              amount: amount,
              status: PaymentItemStatus.final_price,
            )
          ];

          return GooglePayButton(
            paymentConfiguration: snapshot.data!,
            paymentItems: paymentItems,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.connectionState.toString());
          return const Center(
              child: Text('Error loading payment configuration'));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
