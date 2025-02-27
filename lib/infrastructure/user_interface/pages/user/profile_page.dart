import 'package:flutter/material.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_fitness_experience_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_fitness_goals_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_profile_form_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String title = 'My Profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: const AppBarWidget(
          title: ProfilePage.title,
        ),
        body: Column(
          children: [
            TabBar(
              labelColor: AppColorScheme.primary,
              unselectedLabelColor: AppColorScheme.onLightBackground,
              indicatorColor: AppColorScheme.primary,
              tabs: const [
                Tab(icon: Icon(Icons.person), text: "Profile"),
                Tab(icon: Icon(Icons.fitness_center), text: "My goals"),
                Tab(icon: Icon(Icons.graphic_eq), text: "My experience"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        children: [
                          UserProfileFormWidget(
                            user: userProvider.user,
                            onSubmit: (Map<String, dynamic> formData) async {
                              final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false,
                              );
                              try {
                                await userProvider.updateProfile(formData);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Profile updated!",
                                      style: TextStyle(
                                        color: AppColorScheme.onPrimary,
                                      ),
                                    ),
                                    backgroundColor: AppColorScheme.primary,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              } catch (e) {
                                ExceptionHandler().handleException(context, e);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            child: FloatingCenteredButtonWidget(
                              backgroundColor: AppColorScheme.error,
                              foregroundColor: AppColorScheme.onPrimary,
                              onPressed: () async {
                                final userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                );
                                await userProvider.deleteCurrentUser();
                              },
                              text: "Delete my profile",
                            ),
                          )
                        ],
                      )),
                  // Tab 2: My goals
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: UserFitnessGoalsFormWidget(
                      user: userProvider.user,
                      onSubmit: (Map<String, dynamic> formData) async {
                        final userProvider = Provider.of<UserProvider>(
                          context,
                          listen: false,
                        );
                        try {
                          await userProvider.updateUserFitnessGoals(formData);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Goals updated!",
                                style: TextStyle(
                                  color: AppColorScheme.onPrimary,
                                ),
                              ),
                              backgroundColor: AppColorScheme.primary,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        } catch (e) {
                          ExceptionHandler().handleException(context, e);
                        }
                      },
                    ),
                  ),
                  // Tab 3: My level (Placeholder content)
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: UserFitnessExperienceFormWidget(
                      user: userProvider.user,
                      onSubmit: (Map<String, dynamic> formData) async {
                        final userProvider = Provider.of<UserProvider>(
                          context,
                          listen: false,
                        );
                        try {
                          await userProvider
                              .updateUserFitnessExperience(formData);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Experience updated!",
                                style: TextStyle(
                                  color: AppColorScheme.onPrimary,
                                ),
                              ),
                              backgroundColor: AppColorScheme.primary,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        } catch (e) {
                          ExceptionHandler().handleException(context, e);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
