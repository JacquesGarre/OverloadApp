import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/onboarding_pages.dart';

class OnboardUserPage extends StatefulWidget {
  const OnboardUserPage({super.key});

  @override
  State<OnboardUserPage> createState() => _OnboardUserPageState();
}

class _OnboardUserPageState extends State<OnboardUserPage> {
  final onboardUserPageKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: onboardUserPageKey,
      pages: OnboardingPages.pages(context, onboardUserPageKey),
      showDoneButton: false,
      showSkipButton: false,
      showNextButton: false,
      freeze: true,
    );
  }
}
