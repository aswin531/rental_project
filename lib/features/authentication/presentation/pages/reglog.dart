// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class LoginRegSelectionScreen extends StatelessWidget {
  final ValueNotifier<bool> isLoginActive = ValueNotifier<bool>(true);

  LoginRegSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 100.h,
              ),
              Image.asset("assets/images/land.jpg"),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Rent The Wheels",
                style: CustomTextStyles.landingtext,
              ),
              Text(
                "Drive Like Never Before",
                style: CustomTextStyles.landingtext,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "We take care of the details, so you can focus on the fun. Hassle-free booking, reliable vehicles, and 24/7 support keep your adventure rolling.",
                style: CustomTextStyles.bodyText2,
              ),
              SizedBox(
                height: 35.h,
              ),
              Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: grey, width: 2.h),
                    borderRadius: BorderRadius.circular(20)),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        isLoginActive.value = true;
                        _navigateToPage(context);
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLoginActive,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              color: value ? primary : transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 100.h,
                            height: 50.h,
                            alignment: Alignment.center,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: value ? white : black,
                                  fontSize: value ? 20 : 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15.h,
                    ),
                    GestureDetector(
                      onTap: () async{
                        isLoginActive.value = false;
                        _navigateToPage(context);
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLoginActive,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              color: !value ? primary : transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 100.h,
                            height: 50.h,
                            alignment: Alignment.center,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: !value ? white : black,
                                  fontSize: !value ? 20 : 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ));
  }

  void _navigateToPage(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (isLoginActive.value) {
      context.go('/login');
    } else {
      context.go('/register');
    }
  }
}
