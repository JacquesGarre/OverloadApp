import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:overload/infrastructure/layout/app_page.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class BottomBarWidget extends StatelessWidget {
  final List<AppPage> pages;
  final int currentPageIndex;
  final ValueChanged<int> onPageChanged;

  const BottomBarWidget({
    super.key,
    required this.pages,
    required this.currentPageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onPageChanged,
      selectedIndex: currentPageIndex,
      destinations: pages.map((page) {
        return NavigationDestination(
          icon: Iconify(
            page.icon,
            color: page.index == currentPageIndex ? AppColorScheme.primary : AppColorScheme.onLightBackground,
            size: 28,
          ),
          label: page.title,
        );
      }).toList(),
    );
  }
}
