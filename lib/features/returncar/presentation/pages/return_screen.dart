import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/di/dependency_injection.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_bloc.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_event.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_state.dart';
import 'package:rentit/features/returncar/presentation/pages/confirming_return.dart';

class InitiateCarReturnButton extends StatelessWidget {
  final String rentalId;
  const InitiateCarReturnButton(this.rentalId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarReturnBloc, CarReturnState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            BlocProvider.of<CarReturnBloc>(context).add(
              CarReturnInitiate(rentalId),
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ConfirmCarReturnForm(firebaseAuthInstance.currentUser!.uid),
            ));
          },
          child: state is CarReturnInProgress
              ? const CircularProgressIndicator()
              : const Text('Initiate Return'),
        );
      },
    );
  }
}
