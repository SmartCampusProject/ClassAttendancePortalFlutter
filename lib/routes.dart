import 'package:classattendanceportal/view/admin.dart';
import 'package:classattendanceportal/view/auth/forgot_password.dart';
import 'package:classattendanceportal/view/auth/login.dart';
import 'package:classattendanceportal/view/auth/register.dart';
import 'package:classattendanceportal/view/auth/verification.dart';
import 'package:classattendanceportal/view/student.dart';
import 'package:classattendanceportal/view/teacher.dart';
import 'package:get/get.dart';

const String ROUTE_LOGIN = '/login';
const String ROUTE_REGISTER = '/register';
const String ROUTE_HOME = '/home';
const String ROUTE_FORGOT_PASSWORD = '/forgot-password';
const String ROUTE_VERIFICATION = '/verification';
const String ROUTE_TEACHER = '/teacher';
const String ROUTE_ADMIN = '/admin';
const String ROUTE_STUDENT = '/student';

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
      GetPage(
        name: ROUTE_FORGOT_PASSWORD,
        page: () => const ForgotPasswordScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: ROUTE_TEACHER,
        page: () => const TeacherScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: ROUTE_ADMIN,
        page: () => const AdminScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: ROUTE_STUDENT,
        page: () => const StudentScreen(),
        transition: Transition.noTransition,
      ),
      GetPage(
        name: ROUTE_VERIFICATION,
        page: () => const VerificationScreen(),
        transition: Transition.noTransition,
      ),
    ];
  }
}
