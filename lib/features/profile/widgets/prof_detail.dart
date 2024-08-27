import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              shadowColor: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: 345.w,
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
                      onPressed: () {
                        context.push("/accountprof");
                      },
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.envelope,
                      title: 'My Bookings',
                      onPressed: () {},
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.gear,
                      title: 'Settings',
                      onPressed: () {},
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.headset,
                      title: 'Help Center',
                      onPressed: () {},
                    ),
                    SizedBox(height: 10.h),
                    _buildProfileRow(
                      icon: FontAwesomeIcons.shield,
                      title: 'Privacy',
                      onPressed: () {},
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

  Widget _buildProfileRow({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 15.w),
          // Expanded(
          //   child: Text(title, style: CustomProfileTextStyles.bioprofStyle),
          // ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.blue),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
