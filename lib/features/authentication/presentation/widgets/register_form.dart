import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_form_field.dart';
import 'package:rentit/features/authentication/presentation/widgets/custom_text_styles.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPassController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;

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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextFormField(
                labelText: "Name",
                controller: nameController,
                keyboardType: TextInputType.name,
                // validator: (p0) {},
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                labelText: "Last name",
                controller: lastNameController,
                keyboardType: TextInputType.name,
                // validator: (p0) {},
              ),
              SizedBox(height: 20.h),
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
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                // validator: (p0) {},
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                labelText: "Confirm password",
                controller: confirmPassController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                // validator: (p0) {},
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(SignUpEmailPasswordEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                  },
                  child: Text(
                    "Sign up",
                    style: CustomTextStyles.buttonlabeltext.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
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
