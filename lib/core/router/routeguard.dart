
// import 'package:flutter/material.dart';
// import 'package:rentit/core/di/dependency_injection.dart';
// import 'package:rentit/features/authentication/presentation/bloc/authentication_bloc.dart';

// class RouteGuard {
//   static Future<bool> canActivate(BuildContext context) async {
//     final authBloc = sl<AuthBloc>();
//     final token = await authBloc.getAuthToken();
//     return token != null;
//   }
// }

// // Usage in your routes:
// MaterialPageRoute(
//   builder: (context) => FutureBuilder<bool>(
//     future: RouteGuard.canActivate(context),
//     builder: (context, snapshot) {
//       if (snapshot.hasData && snapshot.data == true) {
//         return ProtectedPage();
//       } else {
//         return LoginPage();
//       }
//     },
//   ),
// )