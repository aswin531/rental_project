import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/otp_form.dart';

class ConfirmOtpScreen extends StatelessWidget {
  const ConfirmOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, Authstate>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/profilemain');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              closeIconColor: primary,
              content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: RentItColors.background,
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                    Text(
                      "Almost there",
                      style: CustomTextStyles.headline3,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Please enter the 4-digit code sent to ",
                        style: CustomTextStyles.captiongrey,
                      ),
                      Text(
                        "your number for verification",
                        style: CustomTextStyles.captiongrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                OtpForm(otpColor: Colors.grey[300]!),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250.h,
                    height: 45.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(const VerifyPhoneCodeEvent(
                            smsCode: "", verificationId: ''));
                      },
                      child: Text(
                        "Verify",
                        style: CustomTextStyles.buttonlabeltext,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
