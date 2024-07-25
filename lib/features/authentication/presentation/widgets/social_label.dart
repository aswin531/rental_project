import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/core/constants/colors.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class SocialMediaLabel extends StatelessWidget {
  const SocialMediaLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, Authstate>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/navBarBottom');
        } else if (state is AuthError) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              closeIconColor: primary,
              content: Text(state.message)));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: 70.w,
              height: 40.h,
              child: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignInGoogleEvent());
                },
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.h,
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: 70.w,
              height: 40.h,
              child: IconButton(
                onPressed: () {
                  context.go('/mobilereg');
                },
                icon: Icon(
                  FontAwesomeIcons.mobileScreen,
                  color: black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
