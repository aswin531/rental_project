import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';

class SocialLabelMobileScreen extends StatelessWidget {
  const SocialLabelMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: containerbg,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300.w,
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInGoogleEvent());
                },
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: black,
                ),
              ),
              Text(
                "Continue with Google",
                style: TextStyle(color: black, fontSize: 18.sp),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          decoration: BoxDecoration(
            color: containerbg,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300.w,
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mail,
                  color: black,
                ),
              ),
              SizedBox(
                width: 15.h,
              ),
              Text(
                "Continue with Mail",
                style: TextStyle(color: black, fontSize: 18.sp),
              )
            ],
          ),
        )
      ],
    );
  }
}
