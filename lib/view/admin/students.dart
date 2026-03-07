import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminStudents extends StatefulWidget {
  const AdminStudents({super.key});

  @override
  State<AdminStudents> createState() => _AdminStudentsState();
}

class _AdminStudentsState extends State<AdminStudents> {
  final List<Map<String, String>> _students = [
    {
      'id': 'STU-1001',
      'name': 'Alice Smith',
      'email': 'alice@student.edu',
      'grade': '10th',
    },
    {
      'id': 'STU-1002',
      'name': 'Bob Jones',
      'email': 'bob@student.edu',
      'grade': '11th',
    },
    {
      'id': 'STU-1003',
      'name': 'Charlie Brown',
      'email': 'charlie@student.edu',
      'grade': '10th',
    },
    {
      'id': 'STU-1004',
      'name': 'Diana Prince',
      'email': 'diana@student.edu',
      'grade': '12th',
    },
  ];

  void _showAddStudentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ShadDialog(
          title: const Text('Add New Student'),
          description: const Text(
            'Enter the details of the new student here. Click save when you\'re done.',
          ),
          actions: [
            ShadButton.outline(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ShadButton(
              child: const Text('Save Student'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          child: Container(
            width: 375,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const ShadInput(placeholder: Text('Name')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Email')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Grade')),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeStudent(Map<String, String> student) {
    setState(() {
      _students.remove(student);
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
                    Text("Students", style: theme.textTheme.h3),
                    const SizedBox(height: 8),
                    Text(
                      "Manage enrolled students and their attendance records.",
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
                          Text('Add Student'),
                        ],
                      ),
                      onPressed: _showAddStudentDialog,
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
                        Text("Students", style: theme.textTheme.h3),
                        const SizedBox(height: 8),
                        Text(
                          "Manage enrolled students and their attendance records.",
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
                          Text('Add Student'),
                        ],
                      ),
                      onPressed: _showAddStudentDialog,
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
                              DataColumn(label: Text('Student')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Grade')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: _students
                                .map((student) => _buildRow(student, theme))
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

  DataRow _buildRow(Map<String, String> student, ShadThemeData theme) {
    final initials = student['name']!
        .split(' ')
        .map((n) => n[0])
        .take(2)
        .join();

    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadAvatar(
                student['name']!,
                placeholder: Text(initials),
                size: const Size(32, 32),
              ),
              const SizedBox(width: 12),
              Text(
                student['name']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        DataCell(Text(student['id']!)),
        DataCell(
          Text(
            student['email']!,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        DataCell(ShadBadge(child: Text(student['grade']!))),
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
                onPressed: () => _removeStudent(student),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
