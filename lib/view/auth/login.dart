import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:classattendanceportal/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart'; // Import AuthService

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<ShadFormState>();
  final AuthService _auth = AuthService(); // Instance of AuthService
  final ValueNotifier<String?> _errorMessage = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.muted,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: theme.colorScheme.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ShadForm(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/image/logo.png", width: 75, height: 150),
                  const SizedBox(height: 16),
                  Text(
                    'login.app_title'.tr,
                    style: theme.textTheme.h3.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),

                  ShadInputFormField(
                    id: 'email',
                    label: Text('common.email'.tr),
                    placeholder: Text('login.email_hint'.tr),
                    leading: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        LucideIcons.mail,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ShadInputFormField(
                    id: 'password',
                    label: Text('common.password'.tr),
                    obscureText: true,
                    placeholder: Text('login.password_hint'.tr),
                    leading: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        LucideIcons.lock,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShadButton.link(
                        onPressed: () => Get.toNamed('/forgot-password'),
                        child: Text("login.forgot_password_link".tr),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: _errorMessage,
                    builder: (context, error, child) {
                      if (error == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          error,
                          style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.destructive,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  ShadButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        final data = formKey.currentState!.value;
                        final String email = data['email'];
                        final String password = data['password'];

                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                            email,
                            password,
                          );
                          if (user != null) {
                            Get.offAllNamed('/home');
                          }
                        } on AuthException catch (e) {
                          Get.snackbar(
                            'errors.login_failed_title'.tr,
                            e.message,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } catch (e) {
                          Get.snackbar(
                            'errors.login_failed_title'.tr,
                            'errors.unexpected_error'.tr,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                    child: Text('login.login'.tr),
                  ),
                  const SizedBox(height: 16),
                  ShadButton.link(
                    onPressed: () => Get.toNamed('/register'),
                    child: Text("login.no_account_register".tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
