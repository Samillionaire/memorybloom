import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const kSurface = Color(0xFFFFF8F5);
const kPrimary = Color(0xFFE8927C);
const kPrimaryDeep = Color(0xFF904B39);
const kOnSurface = Color(0xFF201B17);
const kOnSurfaceVariant = Color(0xFF54433F);
const kBlob = Color(0xFFF7E2D6);
const kDotInactive = Color(0xFFE3D6CC);

const kOnboardingCount = 3;

/// Visual content of a single onboarding page (illustration, title, body).
/// Navigation / dots / next button live in the parent [OnboardingFlow].
class OnboardingContent extends StatelessWidget {
  final Widget illustration;
  final String title;
  final String body;

  const OnboardingContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Expanded(child: Center(child: illustration)),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.literata(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 1.15,
              color: kOnSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            body,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: kOnSurfaceVariant,
            ),
          ),
          // Leaves room for the dots + next button overlaid by the flow.
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}

// ── Page indicator dots ──────────────────────────────────────────────────────

class OnboardingDots extends StatelessWidget {
  final double page; // continuous page value for smooth transitions

  const OnboardingDots({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < kOnboardingCount; i++)
          _buildDot(i),
      ],
    );
  }

  Widget _buildDot(int i) {
    // Closeness of this dot to the current page (1 = active, 0 = far).
    final t = (1 - (page - i).abs()).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 10 + 18 * t, // grows to a pill when active
      height: 10,
      decoration: BoxDecoration(
        color: Color.lerp(kDotInactive, kPrimaryDeep, t),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

// ── Next button (gradient pill with chevrons / check) ────────────────────────

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLast;

  const OnboardingNextButton({
    super.key,
    required this.onTap,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEFA088), Color(0xFFB85C42)],
          ),
          boxShadow: [
            BoxShadow(
              color: kPrimary.withValues(alpha: 0.40),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Icon(
            isLast
                ? Icons.check_rounded
                : Icons.keyboard_double_arrow_right_rounded,
            key: ValueKey(isLast),
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

// ── Reusable blob illustration ───────────────────────────────────────────────

/// A warm rounded blob holding a tilted "photo card" with a main icon, plus a
/// couple of floating accent tiles — echoing the scrapbook aesthetic.
class OnboardingIllustration extends StatelessWidget {
  final IconData mainIcon;
  final IconData accentTopRight;
  final IconData accentBottomLeft;

  const OnboardingIllustration({
    super.key,
    required this.mainIcon,
    required this.accentTopRight,
    required this.accentBottomLeft,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxWidth;
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size * 0.92,
                height: size * 0.92,
                decoration: const BoxDecoration(
                  color: kBlob,
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: size * 0.12,
                right: size * 0.10,
                child: _AccentTile(icon: accentTopRight, size: size * 0.20),
              ),
              Positioned(
                bottom: size * 0.12,
                left: size * 0.10,
                child: _AccentTile(icon: accentBottomLeft, size: size * 0.18),
              ),
              Transform.rotate(
                angle: -0.05,
                child: Container(
                  width: size * 0.46,
                  height: size * 0.54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A3228).withValues(alpha: 0.18),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Icon(mainIcon, size: size * 0.20, color: kPrimary),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AccentTile extends StatelessWidget {
  final IconData icon;
  final double size;
  const _AccentTile({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFDCD2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A3228).withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, size: size * 0.5, color: kPrimaryDeep),
    );
  }
}
