import 'package:flutter/material.dart';

import 'onboarding_common.dart';

/// Onboarding page 3 content. Hosted (with swipe) by [OnboardingFlow].
class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      illustration: OnboardingIllustration(
        mainIcon: Icons.tune_rounded,
        accentTopRight: Icons.group_rounded,
        accentBottomLeft: Icons.folder_rounded,
      ),
      title: 'Set group settings\nbased on your needs',
      body: 'Choose who can upload, and whether guests see all photos '
          'or just their own. Pick the people whose photos auto-sync to '
          'your gallery.',
    );
  }
}
