import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rentit/core/validators/license_validators.dart';
import 'package:rentit/features/rental/domain/entity/rental_entity.dart';

class RentalFormState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();
  final TextEditingController pickupArrivalController = TextEditingController();
  final TextEditingController deliveryTimeController = TextEditingController();
  final TextEditingController deliveryPlaceController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  bool isPickup = false;
  bool isDelivery = false;

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    licenseController.dispose();
    commentController.dispose();
    pickupTimeController.dispose();
    pickupArrivalController.dispose();
    deliveryTimeController.dispose();
    deliveryPlaceController.dispose();
  }
}

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
      title: Column(
        children: [
          Image.asset('assets/images/form_logo.png', height: 35),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Car Rental Request Form',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 600, maxWidth: 700),
        child: SingleChildScrollView(
          child: Form(
            key: formState.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateTimePicker(
                  context,
                  'Start Date & Time',
                  formState.startDate,
                  (date) => formState.startDate = date,
                ),
                _buildDateTimePicker(
                  context,
                  'End Date & Time',
                  formState.endDate,
                  (date) => formState.endDate = date,
                ),
                _buildRadioButton(
                  'Pickup',
                  formState.isPickup,
                  (value) => formState.isPickup = value!,
                ),
                if (formState.isPickup) ...[
                  _buildTextField(
                    controller: formState.pickupTimeController,
                    labelText: 'Pickup Time',
                  ),
                  _buildTextField(
                    controller: formState.pickupArrivalController,
                    labelText: 'Arrival',
                  ),
                ],
                _buildRadioButton(
                  'Delivery',
                  formState.isDelivery,
                  (value) => formState.isDelivery = value!,
                ),
                if (formState.isDelivery) ...[
                  _buildTextField(
                    controller: formState.deliveryTimeController,
                    labelText: 'Delivery Time',
                  ),
                  _buildTextField(
                    controller: formState.deliveryPlaceController,
                    labelText: 'Delivery Place',
                  ),
                ],
                _buildTextField(
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
                _buildTextField(
                  controller: formState.emailController,
                  labelText: 'Email Address',
                  validator: (value) => Validator.emailValidator(value),
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildTextField(
                  controller: formState.addressController,
                  labelText: 'Address',
                  validator: (value) => Validator.requiredValidator(value),
                ),
                _buildTextField(
                  controller: formState.licenseController,
                  labelText: 'Driver\'s License Number', //KL12 20231234567
                  validator: (value) => Validator.driverLicenseValidator(value),
                ),
                _buildTextField(
                  controller: formState.commentController,
                  labelText: 'Additional Comments',
                  maxLines: 3,
                ),
              ],
            ),
          ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildDateTimePicker(
    BuildContext context,
    String label,
    DateTime? selectedDate,
    Function(DateTime) onDateSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDateTime(context, onDateSelected),
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? DateFormat('MMM dd, yyyy HH:mm').format(selectedDate)
                        : 'Select date and time',
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateTime(
      BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateSelected(selectedDateTime);
      }
    }
  }

  Widget _buildRadioButton(
      String label, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
          ),
          Radio<bool>(
            value: true,
            groupValue: value,
            onChanged: onChanged,
          ),
          const Text('Yes'),
          Radio<bool>(
            value: false,
            groupValue: value,
            onChanged: onChanged,
          ),
          const Text('No'),
        ],
      ),
    );
  }

  void _submitForm(BuildContext context) {
    // final userService = UserService();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint('UserId: ${user.uid}');
    } else {
      debugPrint('No user is signed in.');
    }
    if (formState.formKey.currentState!.validate() &&
        formState.startDate != null &&
        formState.endDate != null) {
      final request = RentalRequest(
          carId: carId,
          userId: user!.uid,
          startDate: formState.startDate!,
          endDate: formState.endDate!,
          isPickup: formState.isPickup,
          isDelivery: formState.isDelivery,
          pickupTime: formState.pickupTimeController.text,
          pickupArrival: formState.pickupArrivalController.text,
          deliveryTime: formState.deliveryTimeController.text,
          deliveryPlace: formState.deliveryPlaceController.text,
          name: formState.nameController.text,
          phone: formState.phoneController.text,
          address: formState.addressController.text,
          licenseNumber: formState.licenseController.text,
          comment: formState.commentController.text,
          status: false);

      onSubmit(request);
      Navigator.pop(context);
    }
  }

}
