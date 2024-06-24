import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5), // Minimal background color
            ),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.05),
                Container(
                  width: 120.w,
                  height: 120.h,
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
                SizedBox(height: constraints.maxHeight * 0.02),
                Text(
                  "Create Account",
                  style: CustomTextStyles.headline1.copyWith(
                    color: Colors.black87,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  "Create an account to explore all the rides",
                  style: CustomTextStyles.headline3.copyWith(
                    color: Colors.black54,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.all(20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: RegisterForm(
                          formKey: _formKey,
                          nameController: nameController,
                          lastNameController: lastNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPassController: confirmPassController),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Already have an account?",
                    style: CustomTextStyles.captiongrey.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  "Or continue with",
                  style: CustomTextStyles.caption.copyWith(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                const SocialMediaLabel(),
                SizedBox(height: constraints.maxHeight * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}
