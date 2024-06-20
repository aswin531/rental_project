// screen_util_setup.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilSetup extends StatelessWidget {
  final Widget child;

  const ScreenUtilSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set the design size of your choice
      designSize:const Size(360, 690), 
      splitScreenMode: true,
      builder: (BuildContext context, Widget? widget) {
        return child;
      },
    );
  }
}
