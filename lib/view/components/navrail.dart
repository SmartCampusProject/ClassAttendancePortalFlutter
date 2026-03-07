import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SidebarItemModel {
  final IconData icon;
  final String label;
  final int index;

  SidebarItemModel({
    required this.icon,
    required this.label,
    required this.index,
  });
}

class ShadSidebar extends StatelessWidget {
  final bool isExtended;
  final String headerText;
  final IconData headerIcon;
  final List<SidebarItemModel> items;
  final RxInt currentIndex;
  final Function(int) onItemSelected;
  final VoidCallback? onLogout;

  const ShadSidebar({
    super.key,
    required this.isExtended,
    required this.headerText,
    required this.headerIcon,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final double sidebarWidth = isExtended ? 240 : 80;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: sidebarWidth,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.4),
        border: Border(
          right: BorderSide(color: theme.colorScheme.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: isExtended
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          if (isExtended)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: Text(
                "MENU",
                style: theme.textTheme.muted.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, i) => _SidebarItem(
                item: items[i],
                isExtended: isExtended,
                currentIndex: currentIndex,
                onTap: onItemSelected,
              ),
            ),
          ),
          if (onLogout != null) ...[
            const Divider(height: 32),
            _buildLogoutButton(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = ShadTheme.of(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isExtended
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      headerIcon,
                      size: 20,
                      color: theme.colorScheme.primaryForeground,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      headerText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          : Icon(headerIcon, size: 28, color: theme.colorScheme.primary),
    );
  }

  Widget _buildLogoutButton(ShadThemeData theme) {
    return ShadButton.destructive(
      width: double.infinity,
      padding: isExtended
          ? const EdgeInsets.symmetric(horizontal: 12)
          : EdgeInsets.zero,
      leading: Icon(
        LucideIcons.logOut,
        size: 20,
        color: theme.colorScheme.destructiveForeground,
      ),
      onPressed: onLogout,
      child: isExtended
          ? Text(
              "Logout",
              style: TextStyle(color: theme.colorScheme.destructiveForeground),
            )
          : null,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final SidebarItemModel item;
  final bool isExtended;
  final RxInt currentIndex;
  final Function(int) onTap;

  const _SidebarItem({
    required this.item,
    required this.isExtended,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = currentIndex.value == item.index;
      final theme = ShadTheme.of(context);
      final padding = isExtended
          ? const EdgeInsets.symmetric(horizontal: 12)
          : EdgeInsets.zero;

      final leadingIcon = Icon(
        item.icon,
        size: 20,
        color: isSelected
            ? theme.colorScheme.primaryForeground
            : theme.colorScheme.foreground,
      );

      final label = isExtended
          ? Text(
              item.label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            )
          : null;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: isSelected
            ? ShadButton(
                width: double.infinity,
                height: 50.0,
                onPressed: () => onTap(item.index),
                padding: padding,
                leading: leadingIcon,
                mainAxisAlignment: isExtended
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                child: label,
              )
            : ShadButton.ghost(
                width: double.infinity,
                height: 50.0,
                onPressed: () => onTap(item.index),
                padding: padding,
                leading: leadingIcon,
                mainAxisAlignment: isExtended
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                child: label,
              ),
      );
    });
  }
}

class ShadBottomBar extends StatelessWidget {
  final List<SidebarItemModel> items;
  final RxInt currentIndex;
  final Function(int) onItemSelected;

  const ShadBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          border: Border(
            top: BorderSide(color: theme.colorScheme.border, width: 1),
          ),
        ),
        padding: EdgeInsets.only(
          left: 4,
          right: 4,
          top: 8,
          bottom: MediaQuery.paddingOf(context).bottom + 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final isSelected = currentIndex.value == item.index;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: isSelected
                    ? ShadButton(
                        height: 60,
                        padding: EdgeInsets.zero,
                        onPressed: () => onItemSelected(item.index),
                        child: _buildVerticalMenu(
                          item,
                          isSelected,
                          theme.colorScheme.primaryForeground,
                        ),
                      )
                    : ShadButton.ghost(
                        height: 60,
                        padding: EdgeInsets.zero,
                        onPressed: () => onItemSelected(item.index),
                        child: _buildVerticalMenu(
                          item,
                          isSelected,
                          theme.colorScheme.mutedForeground,
                        ),
                      ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildVerticalMenu(
    SidebarItemModel item,
    bool isSelected,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          item.label,
          style: TextStyle(
            fontSize: 10, // Slightly smaller for vertical layout
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
