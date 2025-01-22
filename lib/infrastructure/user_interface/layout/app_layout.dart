import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:overload/infrastructure/user_interface/pages/exercise/exercises_page.dart';
import 'package:overload/infrastructure/user_interface/pages/home_page.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/workouts_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/user_interface/layout/app_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/bottom_bar_widget.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late AppPage _currentPage;
  int _currentPageIndex = 2;

  final List<AppPage> _pages = [
    AppPage(
      index: 0,
      title: HomePage.title,
      page: const HomePage(),
      icon: Ri.home_2_line,
    ),
    AppPage(
      index: 1,
      title: ExercisesPage.title,
      page: const ExercisesPage(),
      icon: Healthicons.exercise,
    ),
    AppPage(
      index: 2,
      title: WorkoutsPage.title,
      page: const WorkoutsPage(),
      icon: Healthicons.exercise_weights,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[_currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _currentPage.title),
      body: _currentPage.page,
      bottomNavigationBar: BottomBarWidget(
        pages: _pages,
        currentPageIndex: _currentPageIndex,
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
            _currentPage = _pages[_currentPageIndex];
          });
        },
      ),
    );
  }
}
