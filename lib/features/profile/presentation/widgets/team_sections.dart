import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/profile/presentation/widgets/mybooking.dart';
import 'package:rentit/features/profile/presentation/widgets/privacypolicy.dart';
import 'package:rentit/features/profile/presentation/widgets/sections.dart';
import 'package:rentit/features/profile/presentation/widgets/team_item.dart';

class TeamSection extends StatelessWidget {
  TeamSection({super.key});

  final List<Map<String, dynamic>> teamItems = [
    {
      'title': 'My Account',
      'subtitle': '',
      'avatars': [
        'assets/images/admin.jpg',
      ],
      'icon': FontAwesomeIcons.user
    },
    {
      'title': 'My Bookings',
      'subtitle': 'Completed',
      'avatars': [
        'assets/images/admin.jpg',
      ],
      'icon': FontAwesomeIcons.calendarCheck
    },
    {
      'title': 'Settings',
      'subtitle': '',
      'avatars': ['assets/images/admin.jpg'],
      'icon': FontAwesomeIcons.gears
    },
    {
      'title': 'Privacy Policy',
      'subtitle': '',
      'avatars': [
        'assets/images/admin.jpg',
      ],
      'icon': FontAwesomeIcons.eye
    },
    {
      'title': 'Logout',
      'subtitle': '',
      'avatars': ['assets/images/admin.jpg'],
      'icon': FontAwesomeIcons.arrowRightFromBracket,
    },
  ];

  final Map<String, Widget> sectionScreens = {
    'My Account': const MyAccountPage(),
    'My Bookings':  BookingDetailScreen(),
    'Settings': const SettingsPage(),
    'Privacy Policy':  PrivacyPolicy(),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ...teamItems.map((item) {
          return GestureDetector(
            onTap: () {
              if (item['title'] == 'Logout') {
                _showLogoutDialog(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sectionScreens[item['title']]!,
                  ),
                );
              }
            },
            child: TeamItem(
              title: item['title'],
              subtitle: item['subtitle'],
              avatars: item['avatars'],
              icon: item['icon'],
            ),
          );
        }),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                context.go('/login');
                context.read<AuthBloc>().add(SignOutEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
