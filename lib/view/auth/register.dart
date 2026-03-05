import 'package:classattendanceportal/enums/department.dart';
import 'package:classattendanceportal/enums/faculty.dart';
import 'package:classattendanceportal/enums/user_role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<ShadFormState>();
  UserRole? selectedRole;
  String deptSearch = '';

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
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
                    'register.create_account'.tr,
                    style: theme.textTheme.h3.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),

                  _buildLabel('register.account_type'.tr, theme),
                  ShadSelectFormField<UserRole>(
                    id: 'role',
                    placeholder: Text('register.select_role'.tr),
                    options: UserRole.values
                        .map(
                          (r) => ShadOption(
                            value: r,
                            child: Text(r.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    selectedOptionBuilder: (context, value) =>
                        Text(value.name.toUpperCase()),
                    onChanged: (v) => setState(() => selectedRole = v),
                  ),
                  const SizedBox(height: 16),

                  ShadInputFormField(
                    id: 'name',
                    leading: Icon(
                      LucideIcons.user,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text('register.full_name'.tr),
                    placeholder: Text('register.full_name_hint'.tr),
                  ),
                  const SizedBox(height: 16),

                  if (selectedRole == UserRole.student) ...[
                    ShadInputFormField(
                      id: 'studentId',
                      leading: Icon(
                        LucideIcons.hash,
                        color: theme.colorScheme.primary,
                      ),
                      label: Text('register.student_id'.tr),
                      placeholder: Text('register.student_id_hint'.tr),
                    ),
                    const SizedBox(height: 16),
                  ],

                  ShadInputFormField(
                    id: 'email',
                    leading: Icon(
                      LucideIcons.mail,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text('common.email'.tr),
                    placeholder: Text('register.email_hint_register'.tr),
                  ),
                  const SizedBox(height: 16),

                  ShadInputFormField(
                    id: 'password',
                    leading: Icon(
                      LucideIcons.lock,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text('common.password'.tr),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('register.faculty_and_dept'.tr, theme),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShadSelectFormField<Faculty>(
                        id: 'faculty',
                        placeholder: Text('register.select_faculty'.tr),
                        options: Faculty.values
                            .map(
                              (f) => ShadOption(value: f, child: Text(f.name)),
                            )
                            .toList(),
                        selectedOptionBuilder: (context, value) =>
                            Text(value.name),
                      ),
                      ShadSelectFormField<Department>.withSearch(
                        id: 'department',
                        placeholder: Text('register.select_department'.tr),
                        searchPlaceholder: Text('register.search'.tr),
                        onSearchChanged: (v) => setState(() => deptSearch = v),
                        options: Department.values
                            .where(
                              (d) => d.name.toLowerCase().contains(
                                    deptSearch.toLowerCase(),
                                  ),
                            )
                            .map(
                              (d) => ShadOption(value: d, child: Text(d.name)),
                            )
                            .toList(),
                        selectedOptionBuilder: (context, value) =>
                            Text(value.name),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  ShadButton(
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        print(
                          'Registration Data: ${formKey.currentState!.value}',
                        );
                      }
                    },
                    child: Text('register.signup'.tr),
                  ),
                  ShadButton.link(
                    onPressed: () => Get.back(),
                    child: Text('register.already_have_account'.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.small.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
