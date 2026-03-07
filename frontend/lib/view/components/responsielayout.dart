import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:get/get.dart';
import 'navrail.dart';

class ResponsiveLayout extends StatelessWidget {
  final String title;
  final IconData headerIcon;
  final List<SidebarItemModel> navItems;
  final RxInt currentIndex;
  final Function(int) onItemSelected;
  final VoidCallback? onLogout;
  final Widget child;

  const ResponsiveLayout({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.navItems,
    required this.currentIndex,
    required this.onItemSelected,
    this.onLogout,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ResponsiveBuilder(
      builder: (context, info) {
        final bool isMobile = info.isMobile || info.isWatch;

        return Scaffold(
          appBar: isMobile
              ? AppBar(
                  backgroundColor: theme.colorScheme.muted.withOpacity(0.4),
                  elevation: 0,
                  title: Row(
                    children: [
                      _BrandIcon(icon: headerIcon),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    if (onLogout != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShadButton.destructive(
                          leading: Icon(
                            LucideIcons.logOut,
                            color: theme.colorScheme.destructiveForeground,
                          ),
                          onPressed: onLogout,
                        ),
                      ),
                  ],
                )
              : null,

          body: Row(
            children: [
              if (!isMobile)
                ShadSidebar(
                  isExtended: info.isDesktop,
                  headerText: title,
                  headerIcon: headerIcon,
                  currentIndex: currentIndex,
                  onItemSelected: onItemSelected,
                  onLogout: onLogout,
                  items: navItems,
                ),

              Expanded(
                child: Container(
                  color: theme.colorScheme.background,
                  child: child,
                ),
              ),
            ],
          ),

          bottomNavigationBar: isMobile
              ? ShadBottomBar(
                  items: navItems,
                  currentIndex: currentIndex,
                  onItemSelected: onItemSelected,
                )
              : null,
        );
      },
    );
  }
}

class _BrandIcon extends StatelessWidget {
  final IconData icon;
  const _BrandIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: theme.colorScheme.primaryForeground),
    );
  }
}
