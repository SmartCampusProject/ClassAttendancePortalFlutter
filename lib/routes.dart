import 'package:classattendanceportal/view/auth/forgot_password.dart';
import 'package:classattendanceportal/view/auth/login.dart';
import 'package:classattendanceportal/view/auth/register.dart';
import 'package:classattendanceportal/view/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String ROUTE_LOGIN = '/login';
const String ROUTE_REGISTER = '/register';
const String ROUTE_HOME = '/home';
const String ROUTE_FORGOT_PASSWORD = '/forgot-password';
const String ROUTE_VERIFICATION = '/verification';

class AppRouter {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: ROUTE_LOGIN,
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: ROUTE_REGISTER,
        page: () => const RegisterScreen(),
      ),
      GetPage(
        name: ROUTE_FORGOT_PASSWORD,
        page: () => const ForgotPasswordScreen(),
      ),
      GetPage(
        name: ROUTE_HOME,
        page: () => const Scaffold(
          body: Center(
            child: Text('Home Page'),
          ),
        ),
      ),
      GetPage(
        name: ROUTE_VERIFICATION,
        page: () => const VerificationScreen(),
      )
    ];
  }
}
