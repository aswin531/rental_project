// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_event.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_state.dart';
import 'package:rentit/features/payments/presentation/pages/review_summary/review_summary_card.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/utils/primary_text.dart';

class ActionButtons extends StatelessWidget {
  final String rentalPrice;
  final String documentId;

  const ActionButtons(
      {super.key, required this.rentalPrice, required this.documentId});

  Future<bool> updatePaymentStatus(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('rental_requests')
          .doc(docId)
          .update({'paymentStatus': 'completed'});
      debugPrint('Payment status updated successfully for document: $docId');
      return true;
    } catch (e) {
      debugPrint('Error updating payment status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update payment status: $e')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentSuccess) {
          bool updateSuccess = await updatePaymentStatus(context, documentId);

          if (updateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Payment successful and status updated!')),
            );
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Lottie.asset("assets/animation/success.json"),
              ),
            );
            final user = FirebaseAuth.instance.currentUser!.uid;
            context
                .read<RentalRequestBloc>()
                .add(FetchUserRentalRequestsWithCarDetailsEvent(user));

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ReviewSummaryScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Payment successful, but failed to update status. Please contact support.')),
            );
          }
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment failed: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle cancel action
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: state is PaymentLoading
                  ? null
                  : () {
                      context.read<PaymentBloc>().add(MakePaymentEvent(
                          amount: double.parse(rentalPrice).toInt(),
                          currency: 'usd'));
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: PrimaryText(
                text: 'Pay to proceed $rentalPrice',
                size: 14,
              ),
            ),
          ],
        );
      },
    );
  }
}
