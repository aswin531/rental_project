
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(
              labelText: "Email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // validator: (p0) {},
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              labelText: "Password",
              controller: passwordController,
              keyboardType:
                  TextInputType.visiblePassword,
              obscureText: true,
              // validator: (p0) {},
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style:
                      CustomTextStyles.caption.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  // padding:
                  //     EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Sign In",
                  style: CustomTextStyles
                      .buttonlabeltext
                      .copyWith(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
