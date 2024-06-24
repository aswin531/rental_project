import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/pages/login_screen.dart';
import 'package:rentit/features/authentication/presentation/pages/register_screen.dart';


final GoRouter router = GoRouter(routes: [
  //GoRoute(path: '/',builder: (context, state) =>LoginRegSelectionScreen() ,),
  GoRoute(
    path: '/',
    builder: (context, state) =>  LoginScreen(),
  ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) =>  RegisterScreen(),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const MobileNumberRegScreen(),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const ConfirmOtpScreen(),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const LocationAccessScreen(),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const MainProfileScreen(),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => BottomNavBarScreen(),
  // ),
]);
