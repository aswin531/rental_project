import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/core/constants/colors.dart';

class SocialMediaLabel extends StatelessWidget {
  const SocialMediaLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 5, // Add elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: 70.w,
            height: 40.h,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.google,
                color: black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.h,
        ),
        Card(
          elevation: 5, // Add elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: 70.w,
            height: 40.h,
            child: Icon(
              FontAwesomeIcons.mobileScreen,
              color: black,
            ),
          ),
        ),
      ],
    );
  }
}
