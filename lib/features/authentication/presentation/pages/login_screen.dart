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
      // body: BlocProvider(
      // create: (context) => AuthBloc(
      //   signInWithGoogle:
      //       SignInWithGoogle(repositrory: context.read<AuthRepository>()),
      //   signInWithPhoneNumber:
      //       SignInWithPhoneNumber(repository: context.read<AuthRepository>()),
      //   // getCurrentUser:
      //   //     GetCurrentUser(repository: context.read<AuthRepository>()),
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: RentItColors.background,
            ),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  "Login here",
                  style: CustomTextStyles.headline1.copyWith(
                    color: Colors.black87,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
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
                SizedBox(height: 10.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      padding: EdgeInsets.all(16.h),
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
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/defprofile.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(66, 72, 214, 12),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              LoginFormWidget(
                                  formKey: _formKey,
                                  emailController: emailController,
                                  passwordController: passwordController),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
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
                SizedBox(height: constraints.maxHeight * 0.009),
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
    //);
  }
}
