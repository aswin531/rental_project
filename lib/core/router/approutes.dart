import 'package:go_router/go_router.dart';
import 'package:rentit/features/authentication/presentation/pages/confirm_otp.dart';
import 'package:rentit/features/authentication/presentation/pages/login_screen.dart';
import 'package:rentit/features/authentication/presentation/pages/phone_number_register.dart';
import 'package:rentit/features/authentication/presentation/pages/register_screen.dart';
import 'package:rentit/features/authentication/presentation/pages/reglog.dart';
import 'package:rentit/features/cardetail/cardetailpage.dart';
import 'package:rentit/features/home/presentation/pages/carlistscreen.dart';
import 'package:rentit/features/profile/pages/profile.dart';
import 'package:rentit/features/profile/widgets/account_page.dart';


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
  GoRoute(
    path: '/accountprof',
    builder: (context, state) => const AccountScreenWidget(),
  ),
  GoRoute(
    path: '/otpconfirm',
    builder: (context, state) => const ConfirmOtpScreen(),
  ),
  GoRoute(
    path: '/profilemain',
    builder: (context, state) => const MainProfileScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const CarListScreen(),
  ),
  // GoRoute(
  //   path: '/detailpage',
  //   builder: (context, state) => const CarDetailPage(),
  // ),
]);
