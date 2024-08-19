import 'package:flutter/material.dart';

class RentalFormState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  // final TextEditingController pickupTimeController = TextEditingController();
  // final TextEditingController pickupArrivalController = TextEditingController();
  // final TextEditingController deliveryTimeController = TextEditingController();
  // final TextEditingController deliveryPlaceController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  DateTime? startTime;
   DateTime? returnTime;
 

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    licenseController.dispose();
    commentController.dispose();
    // pickupTimeController.dispose();
    // pickupArrivalController.dispose();
    // deliveryTimeController.dispose();
    // deliveryPlaceController.dispose();
  }
}