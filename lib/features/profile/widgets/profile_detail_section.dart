import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailSection extends StatelessWidget {
  const ProfileDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Floating effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300.w, // Adjust the width as needed
        height: 200.h, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Name: John Doe',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Email: john.doe@example.com',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Phone: +123 456 7890',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
