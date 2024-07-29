import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rentit/features/authentication/presentation/bloc/authentication_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/bgremovedd.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/logosp.png',
                  height: 250.0,
                  width: 250.0,
                ),
                const SizedBox(height: 20),
                // const Text(
                //   'Rent IT',
                //   style: TextStyle(
                //     fontSize: 24.0,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreenListener extends StatelessWidget {
  const SplashScreenListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, Authstate>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 3), () {
          if (state is AuthAuthenticated) {
            context.go('/navBarBottom');
          } else if (state is AuthUnAuthenticated) {
            context.go('/loginRegSelection');
          }
        });
      },
      child: const SplashScreen(),
    );
  }
}
