import 'package:classattendanceportal/controllers/admin.dart';
import 'package:classattendanceportal/view/components/navrail.dart';
import 'package:classattendanceportal/view/components/responsielayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  final AdminController controller = Get.find<AdminController>();

  final List<SidebarItemModel> navItems = [
    SidebarItemModel(icon: LucideIcons.bookOpen, label: "Courses", index: 0),
    SidebarItemModel(
      icon: LucideIcons.graduationCap,
      label: "Students",
      index: 1,
    ),
    SidebarItemModel(
      icon: LucideIcons.presentation,
      label: "Teachers",
      index: 2,
    ),
    SidebarItemModel(
      icon: LucideIcons.calendarDays,
      label: "Semesters",
      index: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      title: "ADMIN",
      headerIcon: LucideIcons.shieldCheck,
      navItems: navItems,
      currentIndex: controller.selectedIndex,
      onItemSelected: controller.changeIndex,
      onLogout: () => print("Logging out..."),
      child: Obx(
        () => Center(
          child: Text(
            'Current View: ${navItems[controller.selectedIndex.value].label}',
            style: ShadTheme.of(context).textTheme.h3,
          ),
        ),
      ),
    );
  }
}
