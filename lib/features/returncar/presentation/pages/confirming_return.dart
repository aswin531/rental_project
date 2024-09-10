import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_bloc.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_event.dart';
import 'package:rentit/features/returncar/presentation/bloc/return_car_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';

class ConfirmCarReturnForm extends StatefulWidget {
  final String rentalId;

  const ConfirmCarReturnForm(this.rentalId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmCarReturnFormState createState() => _ConfirmCarReturnFormState();
}

class _ConfirmCarReturnFormState extends State<ConfirmCarReturnForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController carIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController lateFeeController = TextEditingController();
  final TextEditingController totalCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocBuilder<CarReturnBloc, CarReturnState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ExternalAppColors.bg,
          //  appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                      text: "Return Confirmation",
                      color: ExternalAppColors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      labelText: 'Car ID',
                      controller: carIdController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Car ID is required' : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      labelText: 'User ID',
                      controller: userIdController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value?.isEmpty == true ? 'User ID is required' : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      labelText: 'Mileage',
                      controller: mileageController,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Mileage is required' : null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      labelText: 'Comments',
                      controller: commentsController,
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      labelText: 'Late Fee',
                      controller: lateFeeController,
                      keyboardType: TextInputType.number,
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 10),
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          final carReturnEntity = CarReturnEntity(
                            carIdController.text,
                            userIdController.text,
                            mileageController.text,
                            DateTime.now(),
                            false,
                            20.0,
                            50,
                            100.toString(),
                            2220.0,
                            10000,
                          );

                          BlocProvider.of<CarReturnBloc>(context).add(
                            CarReturnConfirmation(
                                carReturnEntity, widget.rentalId),
                          );
                        }
                      },
                      child: state is CarReturnInProgress
                          ? const CircularProgressIndicator()
                          : PrimaryText(
                              text: 'Confirm Return',
                              size: 16,
                              color: ExternalAppColors.white,
                            ),
                    ),
                    if (state is CarReturFailure) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    if (state is CarReturnSuccess) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'Return confirmed successfully!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
