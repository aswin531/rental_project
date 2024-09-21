import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/validators/license_validators.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/location/presentation/widgets/locationpicker_bottom_sheet.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';
import 'package:rentit/utils/appcolors.dart';
import 'package:rentit/utils/primary_text.dart';
import 'package:rentit/utils/validation/validator.dart';

class ProfileSetupPage extends StatelessWidget {
  ProfileSetupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityStateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController homeLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          final profileData = {
            'name': nameController.text,
            'job': jobController.text,
            'location': locationController.text,
            'cityState': cityStateController.text,
            'phone': phoneController.text,
            'license': licenseController.text,
            'dob': dobController.text,
            'homeLocation': homeLocationController.text,
          };
          context.read<AuthBloc>().add(CompleteProfileSetupEvent(profileData));
          context.go('/navBarBottom');
        } else if (state is ProfileSetupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        PlatformFile? selectedImage;

        if (state is ProfileImagePickedState) {
          selectedImage = state.file;
        }

        return Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: 'Profile Setup',
              size: 24,
              color: ExternalAppColors.black,
            ),
            centerTitle: true,
            toolbarHeight: 50,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if (result != null) {
                      // ignore: use_build_context_synchronously
                      context
                          .read<ProfileSetupBloc>()
                          .add(ProfileImagePickedEvent(result.files.last));
                    }
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: selectedImage != null
                        ? FileImage(File(selectedImage.path!))
                        : null,
                    child: selectedImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  controller: nameController,
                  label: 'Name',
                  hintText: 'Enter your full name',
                  validator: (value) =>
                      CustomValidator.validateEmptyText('Name', value),
                ),
                const SizedBox(height: 12),
                _buildTextFormField(
                  controller: jobController,
                  label: 'Job',
                  hintText: 'Enter your job title',
                  validator: (value) =>
                      CustomValidator.validateEmptyText('Job', value),
                ),
                const SizedBox(height: 12),
                _buildTextFormField(
                    controller: locationController,
                    readOnly: true,
                    hintText: 'Select your location',
                    validator: (value) =>
                        CustomValidator.validateEmptyText('Location', value),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on),
                      onPressed: () => _showLocationPicker(context),
                    ),
                    label: 'Location'),
                const SizedBox(height: 12),
                _buildTextFormField(
                    hintText: 'Enter your city and state',
                    controller: cityStateController,
                    validator: (value) =>
                        CustomValidator.validateEmptyText('City/State', value),
                    label: 'City/State'),
                const SizedBox(height: 12),
                _buildTextFormField(
                    validator: (value) =>
                        CustomValidator.validateEmptyText('Phone', value),
                    hintText: 'Enter your phone number',
                    controller: phoneController,
                    label: 'Phone',
                    keyboardType: TextInputType.phone),
                const SizedBox(height: 12),
                _buildTextFormField(
                    hintText: 'Enter your driver\'s license number',
                    validator: (value) =>
                        Validator.driverLicenseValidator(value),
                    controller: licenseController,
                    label: 'License'),
                const SizedBox(height: 12),
                TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
    hintText: 'Select your date of birth',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onChanged: (value) {
                    
                  },
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dobController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                const SizedBox(height: 12),
                _buildTextFormField(
                    hintText: 'Enter your home location',
                    validator: (value) => CustomValidator.validateEmptyText(
                        'Home Location', value),
                    controller: homeLocationController,
                    label: 'Home Location'),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: state is ProfileSetupLoading
                      ? null
                      : () {
                          context.read<ProfileSetupBloc>().add(
                                SubmitProfileSetup(
                                  name: nameController.text,
                                  job: jobController.text,
                                  location: locationController.text,
                                  cityState: cityStateController.text,
                                  phone: phoneController.text,
                                  license: licenseController.text,
                                  dob: DateTime.parse(dobController.text),
                                  homeLocation: homeLocationController.text,
                                  profileImage: selectedImage,
                                ),
                              );
                        },
                  child: state is ProfileSetupLoading
                      ? const CircularProgressIndicator()
                      : PrimaryText(
                          text: 'Complete Setup',
                          color: ExternalAppColors.white,
                          size: 20,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool readOnly = false,
    required String hintText,
    Widget? suffixIcon,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      keyboardType: keyboardType,
    
      readOnly: readOnly,
      validator: validator,
    );
  }

  void _showLocationPicker(BuildContext context) {
    try {
      showModalBottomSheet(
        context: context,
        builder: (context) {
        //  final locationMapBloc = BlocProvider.of<LocationMapBloc>(context);
          return LocationPickerBottomSheet(
              onLocationSelected: (String address) {
            locationController.text = address;
            context.pop();
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
