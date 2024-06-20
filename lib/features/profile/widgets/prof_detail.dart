import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/profile/widgets/profile_text_styles.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10, shadowColor: Colors.blueGrey, // Floating effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 345.w, // Adjust the width as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(246, 250, 255, 0.903),
                      Color.fromARGB(77, 191, 200, 214),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileRow(
                      icon: FontAwesomeIcons.user,
                      title: 'Account',
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.envelope,
                      title: 'My Bookings',
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.gear,
                      title: 'Settings',
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.headset,
                      title: 'Help Center',
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.shield,
                      title: 'Privacy',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow({required IconData icon, required String title}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            icon, color: Colors.blue,
            // color: const Color.fromARGB(255, 0, 10, 26)
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Text(title, style: CustomProfileTextStyles.bioprofStyle),
        ),
        const Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
      ],
    );
  }
}
