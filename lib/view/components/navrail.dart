import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:classattendanceportal/controllers/admin.dart';

class ShadSidebar extends StatelessWidget {
  final bool isExtended;
  const ShadSidebar({super.key, required this.isExtended});

  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.find<AdminController>();

    return Container(
      width: isExtended ? 220 : 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.background,
        border: Border(
          right: BorderSide(color: ShadTheme.of(context).colorScheme.border),
        ),
      ),
      child: Column(
        children: [
          // Optional: App Logo/Title
          if (isExtended)
            const Padding(
              padding: EdgeInsets.only(bottom: 24, top: 8),
              child: Text(
                "ADMIN PANEL",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          else
            const FlutterLogo(size: 30),

          const SizedBox(height: 16),

          // Nav Items
          _SidebarItem(
            icon: LucideIcons.layoutDashboard,
            label: 'Dashboard',
            index: 0,
            isExtended: isExtended,
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: LucideIcons.users,
            label: 'Users',
            index: 1,
            isExtended: isExtended,
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: LucideIcons.settings,
            label: 'Settings',
            index: 2,
            isExtended: isExtended,
          ),

          const Spacer(),

          // Bottom Action (Logout)
          ShadButton.ghost(
            leading: const Icon(LucideIcons.logOut, size: 20),
            width: double.infinity,
            child: isExtended ? const Text("Logout") : null,
            onPressed: () => print("Logout pressed"),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isExtended;

  const _SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.isExtended,
  });

  @override
  Widget build(BuildContext context) {
    final AdminController controller = Get.find<AdminController>();

    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;

      // Define the internal content first to avoid repetition
      final childContent = Row(
        mainAxisAlignment: isExtended
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isExtended ? 12 : 0),
            child: Icon(icon, size: 20),
          ),
          if (isExtended)
            Expanded(
              child: Text(label, maxLines: 1, overflow: TextOverflow.clip),
            ),
        ],
      );

      // Switch between constructors based on selection
      if (isSelected) {
        return ShadButton.secondary(
          width: double.infinity,
          onPressed: () => controller.changeIndex(index),
          child: childContent,
        );
      } else {
        return ShadButton.ghost(
          width: double.infinity,
          onPressed: () => controller.changeIndex(index),
          child: childContent,
        );
      }
    });
  }
}
