import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/authentication/presentation/widgets/social_label.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "Login here",
                style: CustomTextStyles.headline1,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "welcome back you've ",
                style: CustomTextStyles.headline2,
              ),
              Text(
                "been missed! ",
                style: CustomTextStyles.headline2,
              ),
              SizedBox(
                height: 45.h,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        // validator: (p0) {},
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextFormField(
                        labelText: "password",
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        // validator: (p0) {},
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: CustomTextStyles.caption,
                            )),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(15)),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(primary),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Sign In",
                              style: CustomTextStyles.buttonlabeltext,
                            )),
                      )
                    ],
                  )),
              SizedBox(
                height: 20.h,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Create a new account",
                    style: CustomTextStyles.captiongrey,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Or continue with ",
                style: CustomTextStyles.caption,
              ),
              SizedBox(
                height: 30.h,
              ),
              const SocialMediaLabel()
            ],
          ),
        )),
      ),
    );
  }
}
