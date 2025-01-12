import 'package:flutter/material.dart';
import 'package:overload/infrastructure/layout/navigation_page.dart';

class BottomBarWidget extends StatelessWidget {
  final List<NavigationPage> pages;
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
          icon: Icon(page.icon),
          label: page.title,
        );
      }).toList(),
    );
  }
}
