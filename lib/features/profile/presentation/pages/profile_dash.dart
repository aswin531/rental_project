import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_event.dart';
import 'package:rentit/features/profile/presentation/bloc/profile_setup/profile_setup_state.dart';
import 'package:rentit/features/profile/presentation/widgets/folder_section.dart';
import 'package:rentit/features/profile/presentation/widgets/profile_card.dart';
import 'package:rentit/features/profile/presentation/widgets/team_sections.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read<ProfileSetupBloc>().firebaseAuth;
    final currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      context.read<ProfileSetupBloc>().add(FetchUserProfile(currentUser.uid));
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
          builder: (context, state) {
            if (state is ProfileSetupLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProfileSetupLoaded) {
              final userProfile = state.userProfile;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ProfileCard(
                        username: userProfile.name,
                      ),
                      const SizedBox(height: 20),
                      const FoldersSection(),
                      const SizedBox(height: 20),
                      TeamSection(),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileSetupError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Please set up your profile.'));
            }
          },
        ),
      ),
    );
  }
}
