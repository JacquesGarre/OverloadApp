import 'package:flutter/material.dart';
import 'package:overload/infrastructure/pages/exercise/exercises_page.dart';
import 'package:overload/infrastructure/pages/home_page.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/layout/app_page.dart';
import 'package:overload/infrastructure/widgets/layout/bottom_bar_widget.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late AppPage _currentPage;
  int _currentPageIndex = 1;

  final List<AppPage> _pages = [
    AppPage(
      title: HomePage.title,
      page: const HomePage(),
      icon: Icons.home_outlined,
    ),
    AppPage(
      title: ExercisesPage.title,
      page: const ExercisesPage(),
      icon: Icons.fitness_center,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[_currentPageIndex];
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
      _currentPage = _pages[_currentPageIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _currentPage.title),
      body: _currentPage.page,
      bottomNavigationBar: BottomBarWidget(
        pages: _pages,
        currentPageIndex: _currentPageIndex,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
