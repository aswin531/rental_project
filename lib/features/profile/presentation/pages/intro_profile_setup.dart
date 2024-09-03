import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';


class ProfileSetupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityStateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController homeLocationController = TextEditingController();

  ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileSetupBloc, ProfileSetupState>(
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          final profileData = {
            'name': nameController.text,
            'job':jobController.text,
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
          appBar: AppBar(title: const Text('Profile Setup')),
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
                      context.read<ProfileSetupBloc>().add(ProfileImagePickedEvent(result.files.first));
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: selectedImage != null
                        ? FileImage(File(selectedImage.path!))
                        : null,
                    child: selectedImage == null
                        ? const Icon(Icons.camera_alt, size: 40)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextFormField(
                  controller: cityStateController,
                  decoration: const InputDecoration(labelText: 'City/State'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextFormField(
                  controller: licenseController,
                  decoration: const InputDecoration(labelText: 'License'),
                ),
                TextFormField(
                  controller: dobController,
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      dobController.text =
                          pickedDate.toIso8601String().split('T')[0];
                    }
                  },
                ),
                TextFormField(
                  controller: homeLocationController,
                  decoration: const InputDecoration(labelText: 'Home Location'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
                      : const Text('Complete Setup'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
