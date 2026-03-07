import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminOverview extends StatelessWidget {
  const AdminOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final theme = ShadTheme.of(context);

        return SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Overview", style: theme.textTheme.h3),
              const SizedBox(height: 8),
              Text(
                "Welcome back, Admin. Here's what's happening today.",
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 32),
              // Summary Cards
              if (isMobile)
                Column(
                  children: [
                    _buildSummaryCard(
                      context,
                      "Total Students",
                      "1,245",
                      Icons.group,
                      Colors.blue,
                      true,
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      context,
                      "Total Teachers",
                      "84",
                      Icons.person,
                      Colors.purple,
                      true,
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      context,
                      "Active Courses",
                      "32",
                      Icons.book,
                      Colors.orange,
                      true,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        "Total Students",
                        "1,245",
                        Icons.group,
                        Colors.blue,
                        false,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        "Total Teachers",
                        "84",
                        Icons.person,
                        Colors.purple,
                        false,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        "Active Courses",
                        "32",
                        Icons.book,
                        Colors.orange,
                        false,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
    bool isMobile,
  ) {
    final theme = ShadTheme.of(context);
    return Container(
      width: isMobile ? double.infinity : null,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
