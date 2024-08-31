import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';
import 'package:rentit/features/authentication/presentation/widgets/register_form.dart';
import 'package:rentit/features/authentication/presentation/widgets/social_label.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RentItColors.background,
          toolbarHeight: 1.h,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF5F5F5), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/land.jpg"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Create Account",
                      style: CustomTextStyles.headline1.copyWith(
                        color: Colors.black87,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Create an account to explore all the rides",
                      style: CustomTextStyles.headline3.copyWith(
                        color: Colors.black54,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RegisterForm(
                        formKey: _formKey,
                        // nameController: nameController,
                        // lastNameController: lastNameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPassController: confirmPassController,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        "Already have an account?",
                        style: CustomTextStyles.captiongrey.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SocialMediaLabel()
                  ]),
            ),
          );
        }));
  }
}
