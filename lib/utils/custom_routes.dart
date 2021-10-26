import 'package:banking_app/1_src/auth/views/auth_screen.dart';
import 'package:banking_app/1_src/auth/views/login_screen.dart';
import 'package:banking_app/1_src/auth/views/signup_screen.dart';
import 'package:banking_app/1_src/home/home_screen.dart';
import 'package:banking_app/1_src/profile/user_profile_screen.dart';
import 'package:get/get.dart';

final List<GetPage<dynamic>> customRoutes = [
  GetPage(
    name: AuthScreen.routeName,
    page: () => AuthScreen(),
  ),
  // GetPage(
  //   name: SixAuthScreen.routeName,
  //   page: () => const SixAuthScreen(),
  // ),
  GetPage(
    name: LogInScreen.routeName,
    page: () => const LogInScreen(),
  ),
  GetPage(
    name: SignUpScreen.routeName,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: UserProfileScreen.routeName,
    page: () => UserProfileScreen(),
  ),
];
