import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminTeachers extends StatefulWidget {
  const AdminTeachers({super.key});

  @override
  State<AdminTeachers> createState() => _AdminTeachersState();
}

class _AdminTeachersState extends State<AdminTeachers> {
  final List<Map<String, String>> _teachers = [
    {
      'id': 'TCH-001',
      'name': 'Prof. John Doe',
      'email': 'john.doe@school.edu',
      'dept': 'Science',
    },
    {
      'id': 'TCH-002',
      'name': 'Dr. Jane Roe',
      'email': 'jane.roe@school.edu',
      'dept': 'Mathematics',
    },
    {
      'id': 'TCH-003',
      'name': 'Mr. Richard Miles',
      'email': 'richard@school.edu',
      'dept': 'History',
    },
  ];

  void _showAddTeacherDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ShadDialog(
          title: const Text('Add New Teacher'),
          description: const Text(
            'Enter the details of the new teacher here. Click save when you\'re done.',
          ),
          actions: [
            ShadButton.outline(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ShadButton(
              child: const Text('Save Teacher'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          child: Container(
            width: 375,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ShadInput(placeholder: Text('Name')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Email')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Department')),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeTeacher(Map<String, String> teacher) {
    setState(() {
      _teachers.remove(teacher);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final theme = ShadTheme.of(context);

        return Padding(
          padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Teachers", style: theme.textTheme.h3),
                    const SizedBox(height: 8),
                    Text(
                      "Manage teaching staff and their class assignments.",
                      style: theme.textTheme.p.copyWith(
                        color: theme.colorScheme.foreground,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ShadButton(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.add, size: 16),
                          ),
                          Text('Add Teacher'),
                        ],
                      ),
                      onPressed: _showAddTeacherDialog,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Teachers", style: theme.textTheme.h3),
                        const SizedBox(height: 8),
                        Text(
                          "Manage teaching staff and their class assignments.",
                          style: theme.textTheme.p.copyWith(
                            color: theme.colorScheme.foreground,
                          ),
                        ),
                      ],
                    ),
                    ShadButton(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Icon(Icons.add, size: 16),
                          ),
                          Text('Add Teacher'),
                        ],
                      ),
                      onPressed: _showAddTeacherDialog,
                    ),
                  ],
                ),
              const SizedBox(height: 32),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    border: Border.all(color: theme.colorScheme.border),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: isMobile
                                ? 800
                                : constraints.maxWidth - 64,
                          ),
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              theme.colorScheme.muted.withValues(alpha: 0.5),
                            ),
                            headingTextStyle: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.foreground,
                            ),
                            dataTextStyle: theme.textTheme.small.copyWith(
                              color: theme.colorScheme.foreground,
                            ),
                            dividerThickness: 1,
                            columns: const [
                              DataColumn(label: Text('Teacher')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: _teachers
                                .map((teacher) => _buildRow(teacher, theme))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DataRow _buildRow(Map<String, String> teacher, ShadThemeData theme) {
    // Extract initials properly even if they have "Prof." or "Dr."
    final parts = teacher['name']!
        .replaceAll(RegExp(r'(Prof\.|Dr\.|Mr\.)\s'), '')
        .split(' ');
    final initials = parts.map((n) => n[0]).take(2).join();

    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadAvatar(
                teacher['name']!,
                placeholder: Text(initials),
                size: const Size(32, 32),
              ),
              const SizedBox(width: 12),
              Text(
                teacher['name']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        DataCell(Text(teacher['id']!)),
        DataCell(
          Text(
            teacher['email']!,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        DataCell(ShadBadge.secondary(child: Text(teacher['dept']!))),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadButton.ghost(
                child: const Icon(Icons.edit, size: 16),
                width: 32,
                height: 32,
                onPressed: () {},
              ),
              ShadButton.ghost(
                child: Icon(
                  Icons.delete,
                  size: 16,
                  color: theme.colorScheme.destructive,
                ),
                width: 32,
                height: 32,
                onPressed: () => _removeTeacher(teacher),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
