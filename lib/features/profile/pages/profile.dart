import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/features/profile/widgets/container_section.dart';
import 'package:rentit/features/profile/widgets/profile_text_styles.dart';
import 'package:rentit/features/profile/widgets/prof_detail.dart';

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/grey.jpg"), // Path to your image
            fit: BoxFit.cover, // Cover the entire container
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Adjust the alignment as needed
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Profile",
                style: CustomProfileTextStyles.mainHeading,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900]
                      ?.withOpacity(0.5), // Adjust opacity for readability
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 150.h,
                height: 150.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/defprofile.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Esther Howard",
                style: CustomProfileTextStyles.nameStyle,
              ),
              SizedBox(
                height: 10.h,
              ),
              const ProfileContainers(),
              const Expanded(child: ProfileDetails())
            ],
          ),
        ),
      ),
    );
  }
}
