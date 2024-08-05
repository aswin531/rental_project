import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/rental/presentation/pages/rental/rental_form.dart';

class BookingButton extends StatelessWidget {
  final String carId;

  const BookingButton({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestBloc, RentalRequestState>(
      listener: (context, state) {
        if (state is RentalRequestCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rental request created successfully!')),
          );
        } else if (state is RentalRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is RentalRequestLoading
              ? null
              : () => _showRentalForm(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: state is RentalRequestLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Book Now'),
        );
      },
    );
  }

  void _showRentalForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RentalFormWidget(
          carId: carId,
          onSubmit: (request) {
            context.read<RentalRequestBloc>().add(CreateRentalRequestEvent(request));
          },
        );
      },
    );
  }
}