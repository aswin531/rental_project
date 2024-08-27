import 'package:flutter/material.dart';
import 'package:rentit/features/profile/widgets/folder_section.dart';
import 'package:rentit/features/profile/widgets/profile_card.dart';
import 'package:rentit/features/profile/widgets/team_sections.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const ProfileCard(),
                const SizedBox(height: 20),
                const FoldersSection(),
                const SizedBox(height: 20),
                TeamSection(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}