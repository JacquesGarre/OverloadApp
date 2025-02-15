import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/onboarding_pages.dart';

class OnboardUserPage extends StatefulWidget {
  const OnboardUserPage({super.key});

  @override
  State<OnboardUserPage> createState() => _OnboardUserPageState();
}

class _OnboardUserPageState extends State<OnboardUserPage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: OnboardingPages.pages(),
      showDoneButton: false,
      showSkipButton: false,
      showNextButton: false,
    );
  }
}
