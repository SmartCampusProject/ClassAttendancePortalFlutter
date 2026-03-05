import 'package:classattendanceportal/view/auth/login.dart';
import 'package:classattendanceportal/view/auth/register.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const ROUTE_LOGIN = "/login";
const ROUTE_REGISTER = "/register";
const ROUTE_HOME = "/home";
const ROUTE_ADMIN = "/admin";
const ROUTE_TEACHER = "/teacher";
const ROUTE_STUDENT = "/student";

class AppRouter {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: ROUTE_LOGIN,
        page: () => const LoginScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: ROUTE_REGISTER,
        page: () => const RegisterScreen(),
        transition: Transition.noTransition,
      ),
    ];
  }
}
