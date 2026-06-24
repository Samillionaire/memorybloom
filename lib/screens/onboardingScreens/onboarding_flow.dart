import 'package:flutter/material.dart';

import '../welcome_screen.dart';
import 'onboarding_common.dart';
import 'onboarding_screen1.dart';
import 'onboarding_screen2.dart';
import 'onboarding_screen3.dart';

/// Swipeable onboarding flow: three pages with a parallax + fade transition,
/// persistent page dots, and a next/finish button.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _controller = PageController();
  double _page = 0;

  static const _pages = [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _page = _controller.page ?? 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext() {
    final current = _page.round();
    if (current < kOnboardingCount - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page.round() == kOnboardingCount - 1;
    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: Stack(
          children: [
            // Swipeable pages with a parallax + fade effect.
            PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, i) {
                final delta = _page - i; // -1..1 near this page
                final t = delta.abs().clamp(0.0, 1.0);
                return Opacity(
                  opacity: 1 - t * 0.55,
                  child: Transform.translate(
                    // Illustration/content drifts for a gentle parallax depth.
                    offset: Offset(delta * 60, 0),
                    child: Transform.scale(
                      scale: 1 - t * 0.06,
                      child: _pages[i],
                    ),
                  ),
                );
              },
            ),

            // Persistent dots + next button.
            Positioned(
              left: 24,
              right: 24,
              bottom: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingDots(page: _page),
                  OnboardingNextButton(onTap: _onNext, isLast: isLast),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
