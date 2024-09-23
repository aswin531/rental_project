import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<AuthBloc, Authstate>(
        listener: (context, state) {
          if (state is AuthUnAuthenticated) {
            // Navigate to login page or initial page when logged out
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.user),
              title: const Text('Account'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to account settings
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.bell),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to notification settings
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.lock),
              title: const Text('Privacy'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.palette),
              title: const Text('Appearance'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to appearance settings
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.headphonesSimple),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to help and support
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.signOutAlt),
              title: const Text('Log Out'),
              onTap: () {
               
              },
            ),
          ],
        ),
      ),
    );
  }
}
