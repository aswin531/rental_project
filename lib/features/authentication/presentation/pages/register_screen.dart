import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/social_label.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Create Account",
                  style: CustomTextStyles.headline1,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "create an account so you ",
                  style: CustomTextStyles.headline3,
                ),
                Text(
                  "can explore all the rides",
                  style: CustomTextStyles.headline3,
                ),
                SizedBox(
                  height: 25.h,
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
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          labelText: "Confirm password",
                          controller: confirmPassController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          // validator: (p0) {},
                        ),
                        SizedBox(
                          height: 30.h,
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
                                "Sign up",
                                style: CustomTextStyles.buttonlabeltext,
                              )),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 25.h,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Already have an account?",
                      style: CustomTextStyles.captiongrey,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Or continue with ",
                  style: CustomTextStyles.caption,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const SocialMediaLabel()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
