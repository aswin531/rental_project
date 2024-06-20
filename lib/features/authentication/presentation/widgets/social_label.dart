import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/core/constants/colors.dart';

class SocialMediaLabel extends StatelessWidget {
  const SocialMediaLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            color: containerbg, borderRadius: BorderRadius.circular(15)),
        width: 70.h,
        height: 40.h,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.google,
              color: black,
            )),
        // child: Image.asset(
        //   "assets/images/iphone.png",
        // ),
      ),
      SizedBox(
        width: 20.h,
      ),
      Container(
        decoration: BoxDecoration(
            color: containerbg, borderRadius: BorderRadius.circular(15)),
        width: 70.h,
        height: 40.h,
        child: Icon(
          FontAwesomeIcons.mobileScreen,
          color: black,
        ),
        // child: Image.asset(
        //   "assets/images/google.png",
        //   fit: BoxFit.cover,
        // ),
      ),
    ]);
  }
}
