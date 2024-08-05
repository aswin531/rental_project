import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/logo_form.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/rental_form.dart';
import 'package:rentit/features/rental/presentation/pages/rental/widgets/rental_form_state.dart';

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
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: () => _submitForm(context),
        ),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint('UserId: ${user.uid}');
    } else {
      debugPrint('No user is currently signed in.');
    }

    if (formState.formKey.currentState!.validate() &&
        formState.startDate != null &&
        formState.endDate != null) {
      final rentalRequest = RentalRequest(
        id: formState.licenseController.text,
        carId: carId,
        userId: user!.uid,
        startDate: formState.startDate!,
        endDate: formState.endDate!,
        isPickup: formState.isPickup,
        isDelivery: formState.isDelivery,
        name: formState.nameController.text,
        phone: formState.phoneController.text,
        email: formState.emailController.text,
        address: formState.addressController.text,
        licenseNumber: formState.licenseController.text,
        comments: formState.commentController.text,
        createdAt: DateTime.now(),
        status: RentalRequestStatus.pending,
      );
      onSubmit(rentalRequest);
      Navigator.pop(context);
    }
  }
}
