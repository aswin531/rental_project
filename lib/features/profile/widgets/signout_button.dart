import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout'),
                content: Text(
                  'Are you sure you want to logout?',
                  style: CustomTextStyles.mobilescreentext,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Color.fromARGB(255, 54, 146, 244),
                          fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(
          FontAwesomeIcons.rightFromBracket,
          color: Colors.white,
        ),
        label: Text(
          'Logout',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 15.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
      ),
    );
  }
}
