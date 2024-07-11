import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/login_form.dart';
import 'package:rentit/features/authentication/presentation/widgets/social_label.dart';
import 'package:rentit/core/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RentItColors.background,
        toolbarHeight: 1.h,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, RentItColors.background],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login here",
                        style: CustomTextStyles.headline1.copyWith(
                          color: Colors.black87,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Welcome back, you've",
                        style: CustomTextStyles.headline2.copyWith(
                          color: Colors.black54,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "been missed!",
                        style: CustomTextStyles.headline2.copyWith(
                          color: Colors.black54,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: LoginFormWidget(
                          formKey: _formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () {
                          context.go('/register');
                        },
                        child: Text(
                          "Create a new account",
                          style: CustomTextStyles.captiongrey.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Or continue with",
                        style: CustomTextStyles.caption.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const SocialMediaLabel(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
