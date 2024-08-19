import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rentit/core/validators/license_validators.dart';
import 'rental_form_state.dart';
import 'rental_form_utils.dart';

class RentalForm extends StatelessWidget {
  final RentalFormState formState;

  const RentalForm({super.key, required this.formState});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildDateTimePicker(
          //   context,
          //   'Start Date & Time',
          //   formState.startDate,
          //   (date) => formState.startDate = date,
          // ),
          // buildDateTimePicker(
          //   context,
          //   'End Date & Time',
          //   formState.endDate,
          //   (date) => formState.endDate = date,
          // ),
          // buildRadioButton(
          //   'Pickup',
          //   formState.isPickup,
          //   (value) => formState.isPickup = value!,
          // ),
          // if (formState.isPickup) ...[
          //   buildTextField(
          //     controller: formState.pickupTimeController,
          //     labelText: 'Pickup Time',
          //   ),
          //   buildTextField(
          //     controller: formState.pickupArrivalController,
          //     labelText: 'Arrival',
          //   ),
          // ],
          // buildRadioButton(
          //   'Delivery',
          //   formState.isDelivery,
          //   (value) => formState.isDelivery = value!,
          // ),
          // if (formState.isDelivery) ...[
          //   buildTextField(
          //     controller: formState.deliveryTimeController,
          //     labelText: 'Delivery Time',
          //   ),
          //   buildTextField(
          //     controller: formState.deliveryPlaceController,
          //     labelText: 'Delivery Place',
          //   ),
          // ],
          buildTextField(
            controller: formState.nameController,
            labelText: 'Full Name',
            validator: (value) => Validator.requiredValidator(value),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntlPhoneField(
              controller: formState.phoneController,
              onChanged: (phone) {},
              decoration: InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(
                  Icons.call,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: const Icon(Icons.backspace),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              initialCountryCode: 'IN',
              onCountryChanged: (country) {},
            ),
          ),
          buildTextField(
            controller: formState.emailController,
            labelText: 'Email Address',
            validator: (value) => Validator.emailValidator(value),
            keyboardType: TextInputType.emailAddress,
          ),
          buildTextField(
            controller: formState.addressController,
            labelText: 'Address',
            validator: (value) => Validator.requiredValidator(value),
          ),
          buildTextField(
            controller: formState.licenseController,
            labelText: 'Driver\'s License Number', //KL12 20231234567
            validator: (value) => Validator.driverLicenseValidator(value),
          ),
          buildTextField(
            controller: formState.commentController,
            labelText: 'Additional Comments',
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
