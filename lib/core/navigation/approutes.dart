import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/pages/login_screen.dart';
import 'package:rentit/features/authentication/presentation/pages/phone_number_register.dart';
import 'package:rentit/features/authentication/presentation/pages/register_screen.dart';
import 'package:rentit/features/authentication/presentation/pages/reglog.dart';


final GoRouter router = GoRouter(routes: [
  GoRoute(path: '/',builder: (context, state) =>LoginRegSelectionScreen() ,),
  GoRoute(
    path: '/login',
    builder: (context, state) =>  LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) =>  RegisterScreen(),
  ),
  GoRoute(
    path: '/mobilereg',
    builder: (context, state) => const MobileNumberRegScreen(),
  ),
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
