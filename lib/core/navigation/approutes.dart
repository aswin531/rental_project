import 'package:go_router/go_router.dart';
import 'package:rentit/features/bottomnav/presentation/pages/bottomnav_with_anicons.dart';
import 'package:rentit/features/profile/pages/profile.dart';

final GoRouter router = GoRouter(routes: [
  //GoRoute(path: '/',builder: (context, state) =>LoginRegSelectionScreen() ,),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) =>  LoginScreen(),
  // ),
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
  GoRoute(
    path: '/',
    builder: (context, state) =>  BottomNavBarWithIcons(),
  ),
]);
