import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_fitness_experience_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_fitness_goals_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_profile_form_widget.dart';
import 'package:provider/provider.dart';

class OnboardingPages {
  static List<PageViewModel> pages(
    BuildContext context,
    GlobalKey<IntroductionScreenState> onboardUserPageKey,
  ) {
    return [
      introductionScreen(onboardUserPageKey),
      profileScreen(context, onboardUserPageKey),
      fitnessGoalsScreen(context, onboardUserPageKey),
      experienceScreen(context, onboardUserPageKey),
    ];
  }

  static PageViewModel introductionScreen(
    GlobalKey<IntroductionScreenState> onboardUserPageKey,
  ) {
    return PageViewModel(
      title: "",
      bodyWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Overload',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Smash your limits with expert-crafted programs, guided workouts, and progress tracking. Whether you\'re lifting for strength, endurance, or aesthetics, Overload keeps you on track.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme.onLightBackground,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Train smarter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColorScheme.onPrimary,
                ),
              ),
              Text(
                'Push further.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColorScheme.onPrimary,
                ),
              ),
              Text(
                'Overload!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 50),
              FloatingCenteredButtonWidget(
                text: "Let's go!",
                onPressed: () {
                  onboardUserPageKey.currentState?.next();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static PageViewModel profileScreen(
    BuildContext context,
    GlobalKey<IntroductionScreenState> onboardUserPageKey,
  ) {
    return PageViewModel(
      title: "",
      bodyWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Set up your profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your information is securely stored only on your device, ensuring privacy while helping us tailor workouts and programs to your goals.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme.onLightBackground,
                ),
              ),
              const SizedBox(height: 26),
              UserProfileFormWidget(
                onSubmit: (Map<String, dynamic> formData) async {
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  try {
                    await userProvider.createUser(formData);
                    if (!context.mounted) return;
                    onboardUserPageKey.currentState?.next();
                  } catch (e) {
                    ExceptionHandler().handleException(context, e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static PageViewModel fitnessGoalsScreen(
    BuildContext context,
    GlobalKey<IntroductionScreenState> onboardUserPageKey,
  ) {
    return PageViewModel(
      title: "",
      bodyWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your Fitness Goals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'To build the perfect workout plan for you, we need to know your goals! Let’s get started on your personalized fitness journey!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme.onLightBackground,
                ),
              ),
              const SizedBox(height: 26),
              UserFitnessGoalsFormWidget(
                onSubmit: (Map<String, dynamic> formData) async {
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  try {
                    await userProvider.updateUserFitnessGoals(formData);
                    if (!context.mounted) return;
                    onboardUserPageKey.currentState?.next();
                  } catch (e) {
                    ExceptionHandler().handleException(context, e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  static PageViewModel experienceScreen(
    BuildContext context,
    GlobalKey<IntroductionScreenState> onboardUserPageKey,
  ) {
    return PageViewModel(
      title: "",
      bodyWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Experience & Training Level',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "To create workouts that match your abilities, we need to know your current experience. Whether you're a beginner, an experienced athlete, or somewhere in between, Overload will tailor your training to challenge you at the right level. Let's find the best starting point for you!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColorScheme.onLightBackground,
                ),
              ),
              const SizedBox(height: 26),
              UserFitnessExperienceFormWidget(
                onSubmit: (Map<String, dynamic> formData) async {
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  try {
                    await userProvider.updateUserFitnessExperience(formData);
                    if (!context.mounted) return;
                    onboardUserPageKey.currentState?.next();
                  } catch (e) {
                    ExceptionHandler().handleException(context, e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
