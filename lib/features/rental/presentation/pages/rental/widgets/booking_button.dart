import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_bloc.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_event.dart';
import 'package:rentit/features/rental/presentation/bloc/rental_bloc/rental_state.dart';
import 'package:rentit/features/rental/presentation/pages/rental/rental_form.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class BookingButton extends StatelessWidget {
  final String carId;

  const BookingButton({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestBloc, RentalRequestState>(
      listener: (context, state) {
        if (state is RentalRequestCreated) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //       content: Text('Rental request created successfully!')),
          // );
        } else if (state is RentalRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 65,
          child: ElevatedButton(
            onPressed: state is RentalRequestLoading
                ? null
                : () => _showRentalForm(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: state is RentalRequestLoading
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryText(
                      text: 'Continue',
                      color: ExternalAppColors.white,
                      size: 20,
                    ),
                  ),
          ),
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
            context
                .read<RentalRequestBloc>()
                .add(CreateRentalRequestEvent(request));
          },
        );
      },
    );
  }
}
