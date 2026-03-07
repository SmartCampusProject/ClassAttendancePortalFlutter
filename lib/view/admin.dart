import 'package:classattendanceportal/controllers/admin.dart';
import 'package:classattendanceportal/view/components/navrail.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          appBar: info.isMobile ? AppBar(title: const Text("Admin")) : null,
          body: Row(
            children: [
              if (info.isTablet || info.isDesktop)
                ShadSidebar(
                  isExtended: info.isDesktop,
                  headerText: "ADMIN",
                  headerIcon: LucideIcons.shieldCheck,
                  currentIndex: controller.selectedIndex,
                  onItemSelected: controller.changeIndex,
                  onLogout: () => print("Logout tapped"),
                  items: navItems,
                ),

              Flexible(
                child: Obx(
                  () => Center(
                    child: Text(
                      'Page: ${controller.selectedIndex.value}',
                      style: ShadTheme.of(context).textTheme.h3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: info.isMobile
              ? ShadBottomBar(
                  items: navItems,
                  currentIndex: controller.selectedIndex,
                  onItemSelected: controller.changeIndex,
                )
              : null,
        );
      },
    );
  }
}
