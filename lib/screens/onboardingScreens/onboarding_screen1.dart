import 'package:flutter/material.dart';

import 'onboarding_common.dart';

/// Onboarding page 1 content. Hosted (with swipe) by [OnboardingFlow].
class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingContent(
      illustration: OnboardingIllustration(
        mainIcon: Icons.photo_camera_front_rounded,
        accentTopRight: Icons.favorite_rounded,
        accentBottomLeft: Icons.image_rounded,
      ),
      title: 'Get your photos\nin one tap!',
      body: 'Share pictures with friends and family without '
          'clogging your gallery. Find your event photos instantly!',
    );
  }
}
