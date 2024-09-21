import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_bloc.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_event.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_state.dart';

class ConfirmCarReturnForm extends StatefulWidget {
  final String rentalId;
  final String carId;

  const ConfirmCarReturnForm(this.rentalId,this.carId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmCarReturnFormState createState() => _ConfirmCarReturnFormState();
}

class _ConfirmCarReturnFormState extends State<ConfirmCarReturnForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController carIdController;
  late TextEditingController userIdController;
  late TextEditingController mileageController;
  late TextEditingController commentsController;
  late TextEditingController lateFeeController;
  late TextEditingController totalCostController;

  @override
  void initState() {
    super.initState();
    carIdController = TextEditingController(text: '');
    userIdController = TextEditingController(
        text: firebaseAuthInstance.currentUser?.uid ?? '');
    mileageController = TextEditingController();
    commentsController = TextEditingController();
    lateFeeController = TextEditingController();
    totalCostController = TextEditingController();

    _fetchRentalDetails();
  }

  void _fetchRentalDetails() {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarReturnBloc, CarReturnState>(
      listener: (context, state) {
        if (state is CarReturnSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Return confirmed successfully!')),
          );
          Navigator.of(context).pop(); // Or navigate to a confirmation screen
        } else if (state is CarReturFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Confirm Car Return')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextFormField(
                    labelText: 'Car ID',
                    controller: carIdController,
                    //    readOnly: true, // Make it read-only if pre-filled
                  ),
                  CustomTextFormField(
                    labelText: 'User ID',
                    controller: userIdController,
                    // readOnly: true,
                  ),
                  CustomTextFormField(
                    labelText: 'Mileage',
                    controller: mileageController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Mileage is required' : null,
                  ),
                  CustomTextFormField(
                    labelText: 'Comments',
                    controller: commentsController,
                  ),
                  CustomTextFormField(
                    labelText: 'Late Fee',
                    controller: lateFeeController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextFormField(
                    labelText: 'Total Cost',
                    controller: totalCostController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty == true
                        ? 'Total cost is required'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
  onPressed: state is CarReturnInProgress
      ? null 
      : () {
          if (_formKey.currentState?.validate() == true) {
            final carReturnEntity = CarReturnEntity(
              carIdController.text,
              userIdController.text,
              mileageController.text,
              DateTime.now(),
              false,
              double.tryParse(lateFeeController.text) ?? 0.0,
              int.tryParse(mileageController.text) ?? 0,
              totalCostController.text,
              double.tryParse(totalCostController.text) ?? 0.0,
              10000, 
            );

            context.read<CarReturnBloc>().add(
                  CarReturnConfirmation(
                      carReturnEntity, widget.rentalId),
                );
          }
        },
  child: state is CarReturnInProgress
      ? const CircularProgressIndicator()
      : const Text('Confirm Return'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    carIdController.dispose();
    userIdController.dispose();
    mileageController.dispose();
    commentsController.dispose();
    lateFeeController.dispose();
    totalCostController.dispose();
    super.dispose();
  }
}
