import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:classattendanceportal/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<ShadFormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.muted,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: theme.colorScheme.card,
            borderRadius: theme.radius,
            border: Border.all(color: theme.colorScheme.border),
          ),
          child: ShadForm(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'forgot_password.title'.tr,
                  style: theme.textTheme.h4.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'forgot_password.instruction'.tr,
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ShadInputFormField(
                  id: 'email',
                  label: Text('forgot_password.email_label'.tr),
                  placeholder: Text('forgot_password.email_hint'.tr),
                ),
                const SizedBox(height: 20),
                ShadButton(
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      final data = formKey.currentState!.value;
                      final String email = data['email'];
                      try {
                        await _auth.sendPasswordResetEmail(email);
                        Get.snackbar(
                          'forgot_password.title'.tr,
                          'forgot_password.success_message'.trParams({'email': email}),
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Get.back();
                      } on AuthException catch (e) {
                        Get.snackbar(
                          'forgot_password.error_title'.tr,
                          e.message,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } catch (e) {
                        Get.snackbar(
                          'forgot_password.error_title'.tr,
                          'errors.unexpected_error'.tr,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                  child: Text('forgot_password.send_reset_link'.tr),
                ),
                ShadButton.link(
                  onPressed: () => Get.back(),
                  child: Text('login.already_have_account'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
