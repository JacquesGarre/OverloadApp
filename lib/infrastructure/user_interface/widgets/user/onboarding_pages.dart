import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:logger/logger.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_profile_form_widget.dart';

class OnboardingPages {
  static List<PageViewModel> pages() {
    return [
      page1(),
      page2(),
    ];
  }

  static PageViewModel page1() {
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  static PageViewModel page2() {
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
                  fontSize: 28,
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
              UserProfileFormWidget(onSubmit: (Map<String, dynamic> formData) {
                Logger().i(formData);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
