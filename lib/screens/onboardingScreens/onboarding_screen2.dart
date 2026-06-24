import 'package:flutter/material.dart';

import 'onboarding_common.dart';

/// Onboarding page 2 content. Hosted (with swipe) by [OnboardingFlow].
class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      illustration: OnboardingIllustration(
        mainIcon: Icons.cloud_done_rounded,
        accentTopRight: Icons.lock_rounded,
        accentBottomLeft: Icons.collections_rounded,
      ),
      title: 'Save phone memory',
      body: "Don't worry about losing data. Every photo is safely "
          'backed up, so you can relive your memories anytime — without '
          'filling up your phone.',
    );
  }
}
