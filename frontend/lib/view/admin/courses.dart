import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminCourses extends StatefulWidget {
  const AdminCourses({super.key});

  @override
  State<AdminCourses> createState() => _AdminCoursesState();
}

class _AdminCoursesState extends State<AdminCourses> {
  final List<Map<String, String>> _courses = [
    {
      'code': 'PHY-101',
      'name': 'Physics 101',
      'teacher': 'Prof. John Doe',
      'status': 'Active',
      'credits': '3',
    },
    {
      'code': 'MAT-201',
      'name': 'Calculus II',
      'teacher': 'Dr. Jane Roe',
      'status': 'Active',
      'credits': '4',
    },
    {
      'code': 'HIS-105',
      'name': 'World History',
      'teacher': 'Mr. Richard Miles',
      'status': 'Inactive',
      'credits': '2',
    },
  ];

  void _showAddCourseDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ShadDialog(
          title: const Text('Add New Course'),
          description: const Text(
            'Enter the details of the new course here. Click save when you\'re done.',
          ),
          actions: [
            ShadButton.outline(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ShadButton(
              child: const Text('Save Course'),
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
                const ShadInput(
                  placeholder: Text('Course Code (e.g. PHY-101)'),
                ),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Course Name')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Teacher')),
                const SizedBox(height: 16),
                const ShadInput(placeholder: Text('Credits')),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeCourse(Map<String, String> course) {
    setState(() {
      _courses.remove(course);
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
                    Text("Courses", style: theme.textTheme.h3),
                    const SizedBox(height: 8),
                    Text(
                      "Manage academic courses, schedules, and subjects.",
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
                          Text('Add Course'),
                        ],
                      ),
                      onPressed: _showAddCourseDialog,
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
                        Text("Courses", style: theme.textTheme.h3),
                        const SizedBox(height: 8),
                        Text(
                          "Manage academic courses, schedules, and subjects.",
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
                          Text('Add Course'),
                        ],
                      ),
                      onPressed: _showAddCourseDialog,
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
                              DataColumn(label: Text('Code')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Teacher')),
                              DataColumn(label: Text('Credits')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: _courses
                                .map((course) => _buildRow(course, theme))
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

  DataRow _buildRow(Map<String, String> course, ShadThemeData theme) {
    final isActive = course['status'] == 'Active';
    return DataRow(
      cells: [
        DataCell(
          Text(
            course['code']!,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        DataCell(Text(course['name']!)),
        DataCell(
          Text(
            course['teacher']!,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        DataCell(
          Text(
            course['credits']!,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        DataCell(
          isActive
              ? ShadBadge(child: Text(course['status']!))
              : ShadBadge.outline(child: Text(course['status']!)),
        ),
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
                onPressed: () => _removeCourse(course),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
