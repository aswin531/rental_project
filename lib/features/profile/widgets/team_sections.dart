import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/profile/widgets/detailed_page.dart';
import 'package:rentit/features/profile/widgets/section_header.dart';
import 'package:rentit/features/profile/widgets/team_item.dart';

class TeamSection extends StatelessWidget {
  TeamSection({super.key});

  final List<Map<String, dynamic>> teamItems = [
    {
      'title': 'Profile',
      'subtitle': 'Project in Progress',
      'avatars': ['assets/images/admin.jpg', 'assets/images/iphone.png'],
      'icon': FontAwesomeIcons.user
    },
    {
      'title': 'My Bookings',
      'subtitle': 'Completed',
      'avatars': ['assets/images/admin.jpg', 'assets/images/iphone.png'],
      'icon': FontAwesomeIcons.calendarCheck
    },
    {
      'title': 'Settings',
      'subtitle': '',
      'avatars': ['assets/images/iphone.png', 'assets/images/admin.jpg'],
      'icon': FontAwesomeIcons.cogs
    },
    {
      'title': 'Privacy Policy',
      'subtitle': '',
      'avatars': ['assets/images/location.jpg', 'assets/images/location.jpg'],
      'icon': FontAwesomeIcons.shieldAlt
    },
    {
      'title': 'My Account',
      'subtitle': '',
      'avatars': ['assets/images/location.jpg', 'assets/images/admin.jpg'],
      'icon': FontAwesomeIcons.userCog
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'My Team'),
        const SizedBox(height: 10),
        ...teamItems.map((item) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(title: item['title']),
                ),
              );
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
}
