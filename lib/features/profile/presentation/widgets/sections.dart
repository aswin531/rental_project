import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/profile/domain/entity/profile_setup_entity.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';
class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final state = BlocProvider.of<ProfileSetupBloc>(context).state;
              if (state is ProfileSetupLoaded) {
                _showEditProfileDialog(context, state.userProfile);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
        builder: (context, state) {
          if (state is ProfileSetupLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSetupLoaded) {
            final profile = state.userProfile;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileImage(context, profile.imageUrl),
                  const SizedBox(height: 20),
                  _buildProfileDetail(title: "Name", value: profile.name),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "Job", value: profile.job),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "Location", value: profile.location),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "City/State", value: profile.cityState),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "Phone", value: profile.phone),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "License", value: profile.license),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "Date of Birth", value: profile.dob.toString()),
                  const SizedBox(height: 10),
                  _buildProfileDetail(title: "Home Location", value: profile.homeLocation),
                ],
              ),
            );
          } else if (state is ProfileSetupError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(
              child: Text('No profile data available.'),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context, String imageUrl) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.person, size: 120),
      ),
    );
  }

  Widget _buildProfileDetail({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, UserProfile profile) {
    final nameController = TextEditingController(text: profile.name);
    final jobController = TextEditingController(text: profile.job);
    final locationController = TextEditingController(text: profile.location);
    final cityStateController = TextEditingController(text: profile.cityState);
    final phoneController = TextEditingController(text: profile.phone);
    final licenseController = TextEditingController(text: profile.license);
    final dobController = TextEditingController(text: profile.dob.toString());
    final homeLocationController = TextEditingController(text: profile.homeLocation);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: jobController, decoration: const InputDecoration(labelText: 'Job')),
                TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
                TextField(controller: cityStateController, decoration: const InputDecoration(labelText: 'City/State')),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
                TextField(controller: licenseController, decoration: const InputDecoration(labelText: 'License')),
                TextField(controller: dobController, decoration: const InputDecoration(labelText: 'Date of Birth')),
                TextField(controller: homeLocationController, decoration: const InputDecoration(labelText: 'Home Location')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedProfile = UserProfile(
                  userId: firebaseAuthInstance.currentUser!.uid,
                  imageUrl: '',
                  name: nameController.text,
                  job: jobController.text,
                  location: locationController.text,
                  cityState: cityStateController.text,
                  phone: phoneController.text,
                  license: licenseController.text,
                  dob: DateTime.parse(dobController.text),
                  homeLocation: homeLocationController.text,
                );
                // Dispatch UpdateProfileEvent
                context.read<ProfileSetupBloc>().add(UpdateProfileEvent(updatedProfile));
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
