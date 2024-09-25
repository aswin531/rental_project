// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_bloc.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_event.dart';
import 'package:rentit/features/payments/presentation/bloc/stripe/stripe_state.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/reviews/presentation/pages/review_screen.dart';
import 'package:rentit/utils/primary_text.dart';

class ActionButtons extends StatelessWidget {
  final String rentalPrice;
  final String documentId;
  final String carId;
  final String imageUrl;

  const ActionButtons({
    super.key,
    required this.rentalPrice,
    required this.documentId,
    required this.carId,
    required this.imageUrl,
  });

  Future<bool> updatePaymentStatus(BuildContext context, String docId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current rental request document
      DocumentSnapshot rentalDoc =
          await firestore.collection('rental_requests').doc(docId).get();

      if (!rentalDoc.exists) {
        throw Exception('Rental document not found');
      }

      Map<String, dynamic> rentalData =
          rentalDoc.data() as Map<String, dynamic>;

      // Add additional fields for completed rentals
      rentalData['paymentStatus'] = 'completed';
      rentalData['completedAt'] = FieldValue.serverTimestamp();

      // Start a batch write
      WriteBatch batch = firestore.batch();

      // Add to completed_rentals collection
      DocumentReference completedRentalRef =
          firestore.collection('completed_rentals').doc(docId);
      batch.set(completedRentalRef, rentalData);

      // Delete from rental_requests collection
      DocumentReference rentalRequestRef =
          firestore.collection('rental_requests').doc(docId);
      batch.delete(rentalRequestRef);

      // Commit the batch
      await batch.commit();

      debugPrint('Rental moved to completed_rentals: $docId');
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
                  content: Text('Payment successful and rental completed!')),
            );
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Lottie.asset("assets/animation/success.json"),
              ),
            );
            final user = FirebaseAuth.instance.currentUser!.uid;

            // Refresh the rental requests list
            context
                .read<RentalRequestBloc>()
                .add(FetchUserRentalRequestsWithCarDetailsEvent(user));

            // Navigate to the review screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ReviewScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Payment successful, but failed to complete rental. Please contact support.')),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
