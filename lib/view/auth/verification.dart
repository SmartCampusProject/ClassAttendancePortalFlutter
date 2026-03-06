import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'verification.title'.tr,
                style: theme.textTheme.h4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'verification.instruction'.tr,
                style: theme.textTheme.small,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ShadButton(
                onPressed: () => Get.offAllNamed('/login'),
                child: Text('verification.back_to_login'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
