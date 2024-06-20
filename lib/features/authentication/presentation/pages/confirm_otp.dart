import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/otp_form.dart';

class ConfirmOtpScreen extends StatelessWidget {
  const ConfirmOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Almost there",
                style: CustomTextStyles.headline3,
              ),
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
                    onPressed: () {},
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
    );
  }
}
