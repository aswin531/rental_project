import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/profile/widgets/signout_button.dart';

class AccountScreenWidget extends StatelessWidget {
  const AccountScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RentItColors.background,
      appBar: AppBar(
        toolbarHeight: 30.h,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        backgroundColor: RentItColors.background,
        title: Text(
          'Account Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, Authstate>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50.w,
                      backgroundColor: RentItColors.primary,
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 50.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20.h,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 30.h),
                        Text('Name: ',
                            style: CustomTextStyles.mobilescreentext),
                        SizedBox(height: 10.h),
                        Icon(
                          FontAwesomeIcons.ccVisa,
                          color: Colors.green,
                          size: 24.h,
                          shadows: const [
                            Shadow(color: Colors.amber),
                            Shadow()
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Phone:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Primary Location:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    const AndroidNotificationDetails
                        androidPlatformChannelSpecifics =
                        AndroidNotificationDetails(
                      'your channel id',
                      'your channel name',
                      importance: Importance.max,
                      priority: Priority.high,
                    );
                    const NotificationDetails platformChannelSpecifics =
                        NotificationDetails(
                            android: androidPlatformChannelSpecifics);
                    await FlutterLocalNotificationsPlugin().show(
                      0,
                      'Test Notification',
                      'This is a test notification',
                      platformChannelSpecifics,
                    );
                  },
                  child: Text('Send Test Notification'),
                ),
                SizedBox(height: 30.h),
                const LogoutButtonWidget()
              ],
            ),
          );
        },
      ),
    );
  }
}
