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

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          appBar: info.isMobile ? AppBar(title: const Text("Admin")) : null,
          body: Row(
            children: [
              // Use the separated widget here
              if (info.isTablet || info.isDesktop)
                ShadSidebar(isExtended: info.isDesktop),

              // Content Area
              Expanded(
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
          bottomNavigationBar: info.isMobile ? _buildBottomNav() : null,
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dash'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
