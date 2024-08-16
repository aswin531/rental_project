import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selected_bloc.dart';
import 'package:rentit/features/home/presentation/bloc/selectedcar/selectedcar_state.dart';
import 'package:rentit/features/profile/widgets/container_section.dart';
import 'package:rentit/features/profile/widgets/profile_text_styles.dart';
import 'package:rentit/features/profile/widgets/prof_detail.dart';

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RentItColors.background,
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            AvatarGlow(
              glowColor: const Color.fromARGB(255, 3, 147, 243),
              glowShape: BoxShape.circle,
              animate: true,
              glowRadiusFactor: 5.0,
              glowCount: 10,
              curve: Easing.emphasizedAccelerate,
              duration: const Duration(milliseconds: 2000),
              repeat: false,
              //startDelay: Duration(seconds: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: transparent,
                  // color: Colors.grey[900]?.withOpacity(0.5),
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
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<SelectedCarBloc, SelectedCarState>(
              builder: (context, state) {
                if (state is CarSelected) {
                  final car = state.car;
                  return Text(
                    car.make,
                    style: CustomProfileTextStyles.nameStyle,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            const ProfileContainers(),
            const Expanded(child: ProfileDetails())
          ],
        ),
      ),
    );
  }
}
