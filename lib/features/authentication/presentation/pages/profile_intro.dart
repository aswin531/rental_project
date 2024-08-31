import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/data/model/user_model.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/utils/primary_text.dart';

class UserIntroProfileDetailsScreen extends StatefulWidget {
  const UserIntroProfileDetailsScreen({super.key});

  @override
  _UserIntroProfileDetailsScreenState createState() =>
      _UserIntroProfileDetailsScreenState();
}

class _UserIntroProfileDetailsScreenState
    extends State<UserIntroProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserDetails _userDetails;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryStateController = TextEditingController();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _userDetails = UserDetails();
  }

  Future<void> _selectProfileImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _profileImage = File(result.files.single.path!);
        // You can also update _userDetails with the path to the selected image here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const PrimaryText(text: 'Complete Your Profile')),
      body: BlocListener<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthProfileUpdated) {
            context.go('/navBarBottom');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: PrimaryText(text: state.message),
                  backgroundColor: Colors.red),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _selectProfileImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Full Name',
                  controller: _fullNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your full name' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Date of Birth',
                  controller: _dobController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your date of birth' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Phone Number',
                  controller: _phoneNumberController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Email Address',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email address' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Residential Address',
                  controller: _addressController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your address' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  labelText: 'Country/State',
                  controller: _countryStateController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your country/state' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _userDetails.preferredCarType,
                  decoration:
                      const InputDecoration(labelText: 'Preferred Car Type'),
                  items: ['Sedan', 'SUV', 'Hatchback', 'Truck']
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _userDetails.preferredCarType = value),
                  validator: (value) =>
                      value == null ? 'Please select a car type' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Complete Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _userDetails
        ..fullName = _fullNameController.text
        ..dateOfBirth = _dobController.text
        ..phoneNumber = _phoneNumberController.text
        ..email = _emailController.text
        ..residentialAddress = _addressController.text
        ..countryState = _countryStateController.text;

      if (_profileImage != null) {
        // _userDetails.profileImagePath = _profileImage!.path;
      }

      context.read<AuthBloc>().add(UpdateUserProfile(_userDetails.toMap()));
    }
  }
}
