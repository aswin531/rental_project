import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/logo_form.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/rental_form.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/rental_form_state.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/rentalrequest_summary.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class RentalFormWidget extends StatelessWidget {
  final String carId;
  final Function(RentalRequest) onSubmit;
  final RentalFormState formState = RentalFormState();

  RentalFormWidget({
    super.key,
    required this.carId,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const LogoAndFormText(),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 600, maxWidth: 700),
        child: SingleChildScrollView(
          child: RentalForm(formState: formState),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                    BorderSide(color: ExternalAppColors.blue)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: ExternalAppColors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9.5),
              ),
              child: PrimaryText(
                text: 'Submit',
                color: ExternalAppColors.white,
                size: 16,
              ),
              onPressed: () => _submitForm(context),
            ),
          ],
        ),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final rentalRequestBloc = context.read<RentalRequestBloc>();
    // rentalRequestBloc
    //     .add(FetchUserRentalRequestsWithCarDetailsEvent(user!.uid));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RentalRequestReviewSummaryScreen(
          carId: carId,
          pickupDate: rentalRequestBloc.pickupDate!,
          returnDate: rentalRequestBloc.returnDate!,
          pickupLocation: rentalRequestBloc.pickupLocation.toString(),
          dropOffLocation: rentalRequestBloc.dropOffLocation.toString(),
          userId: user!.uid,
          name: formState.nameController.text,
          phone: formState.phoneController.text,
          email: formState.emailController.text,
          address: formState.addressController.text,
          licenseNumber: formState.licenseController.text,
          comments: formState.commentController.text,
          returnTime: rentalRequestBloc.returnTime!,
          pickUpTime: rentalRequestBloc.startTime!,
          estimatedKilometersDriven: 0,
          //estimatedKilometersDriven: double.parse(formState.kilometersController.text),
          onSubmit: onSubmit,
        ),
      ),
    );
  }
}
  

  // void _submitForm(BuildContext context) {
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (formState.formKey.currentState!.validate()) {
  //     final rentalRequestBloc = context.read<RentalRequestBloc>();
  //     final state = rentalRequestBloc.state;
  //     if (state is RentalRequestDateTimeState &&
  //         state.pickupDate != null &&
  //         state.returnDate != null) {
  //       final rentalRequest = RentalRequest(
  //         id: formState.licenseController.text,
  //         carId: carId,
  //         userId: user!.uid,
  //         pickUpLocation: rentalRequestBloc.pickupLocation,
  //         dropOffLocation: rentalRequestBloc.dropOffLocation,
  //         pickupDate: rentalRequestBloc.pickupDate!,
  //         returnDate: rentalRequestBloc.returnDate!,
  //         pickupTime: rentalRequestBloc.startTime!,
  //         returnTime: rentalRequestBloc.returnTime!,
  //         name: formState.nameController.text,
  //         phone: formState.phoneController.text,
  //         email: formState.emailController.text,
  //         address: formState.addressController.text,
  //         licenseNumber: formState.licenseController.text,
  //         comments: formState.commentController.text,
  //         createdAt: DateTime.now(),
  //         status: RentalRequestStatus.pending,
  //       );
  //       onSubmit(rentalRequest);
  //       Navigator.pop(context);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //             content: Text('Please select start and end dates/times')),
  //       );
  //     }
  //   }
  // }

