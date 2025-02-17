import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/exercise/exercises_page.dart';
import 'package:overload/infrastructure/user_interface/pages/session/sessions_page.dart';
import 'package:overload/infrastructure/user_interface/pages/user/onboard_user_page.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/workouts_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/user_interface/config/app_page_config.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/bottom_bar_widget.dart';
import 'package:provider/provider.dart';

class AppLayout extends StatefulWidget {
  static int sessionsPageIndex = 0;
  static int workoutsPageIndex = 1;
  static int exercisesPageIndex = 2;

  final int? currentPageIndex;

  const AppLayout({super.key, this.currentPageIndex});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late AppPageConfig _currentPage;
  int _currentPageIndex = 0;

  final List<AppPageConfig> _pages = [
    AppPageConfig(
      index: AppLayout.sessionsPageIndex,
      title: SessionsPage.title,
      page: const SessionsPage(),
      icon: Mdi.calendar_check_outline,
    ),
    AppPageConfig(
      index: AppLayout.workoutsPageIndex,
      title: WorkoutsPage.title,
      page: const WorkoutsPage(),
      icon: Healthicons.exercise_weights,
    ),
    AppPageConfig(
      index: AppLayout.exercisesPageIndex,
      title: ExercisesPage.title,
      page: const ExercisesPage(),
      icon: Healthicons.exercise,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.currentPageIndex != null
        ? widget.currentPageIndex!
        : _currentPageIndex;
    _currentPage = _pages[_currentPageIndex];
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return userProvider.user != null && userProvider.user!.isProfileCompleted() ? Scaffold(
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
    ) : const OnboardUserPage();
  }
}
