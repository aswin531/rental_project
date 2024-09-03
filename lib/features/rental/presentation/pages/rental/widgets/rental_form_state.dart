import 'package:flutter/material.dart';

class RentalFormState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController pickUpLocationController =
      TextEditingController();
  final TextEditingController dropOffController = TextEditingController();
  final TextEditingController kilometersController = TextEditingController();

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    licenseController.dispose();
    commentController.dispose();
    pickUpLocationController.dispose();
    dropOffController.dispose();
    kilometersController.dispose();
  }
}
