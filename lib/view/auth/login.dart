import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:classattendanceportal/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<ShadFormState>();

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
                  const SizedBox(height: 32),

                  ShadButton(
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        print(formKey.currentState!.value);
                      }
                    },
                    child: Text('login.login'.tr),
                  ),
                  const SizedBox(height: 16),
                  ShadButton.link(
                    onPressed: () => Get.toNamed(ROUTE_REGISTER),
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
