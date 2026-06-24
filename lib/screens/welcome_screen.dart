import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36),

              // ── Title ──────────────────────────────────────────────────
              Text(
                'MemoryBloom',
                style: GoogleFonts.literata(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF904B39),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Every moment, kept.',
                style: GoogleFonts.literata(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF86736E),
                ),
              ),
              const SizedBox(height: 20),

              // ── Main area: brown gradient panel + floating card ────────
              Expanded(
                child: Stack(
                  children: [
                    // Brown gradient panel — fades downward into the cream
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFA07060), // warm dark brown top
                              Color(0xFFB89484), // mid taupe
                              Color(0xFFD8C4B8), // light taupe
                              Color(0xFFFFF8F5), // fade into cream
                            ],
                            stops: [0.0, 0.45, 0.72, 1.0],
                          ),
                        ),
                        // Blob photo sits in the upper portion of the panel
                        child: const Align(
                          alignment: Alignment(0, -0.35),
                          child: _BlobPhoto(),
                        ),
                      ),
                    ),

                    // Floating white card — overlaps the faded brown region
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A3228)
                                  .withValues(alpha: 0.10),
                              blurRadius: 30,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 26, 20, 28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Start a new chapter.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF4A3228),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Continue with Google
                            OutlinedButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, '/home'),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 52),
                                side: const BorderSide(
                                    color: Color(0xFFD9C1BC)),
                                shape: const StadiumBorder(),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const _GoogleIcon(),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Continue with Google',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4A3228),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Continue with Email
                            TextButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, '/home'),
                              child: Text(
                                'Continue with Email',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFE8927C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Privacy note (outside card) ────────────────────────────
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline_rounded,
                    size: 13,
                    color: Color(0xFF86736E),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Your memories stay private',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF86736E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Blob-clipped photo ─────────────────────────────────────────────────────

class _BlobPhoto extends StatelessWidget {
  const _BlobPhoto();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 190,
      child: ClipPath(
        clipper: _BlobClipper(),
        child: Image.asset(
          'assets/images/welcome_photo.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFFC4A99A),
            child: const Icon(
              Icons.people_outline_rounded,
              size: 72,
              color: Color(0xFFFFF8F5),
            ),
          ),
        ),
      ),
    );
  }
}

// Organic pebble blob matching the design: irregular with a pointed
// protrusion toward the bottom-right and a flatter top-left edge.
class _BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width;
    final h = s.height;
    return Path()
      // Start top-centre, sweep clockwise
      ..moveTo(w * 0.48, h * 0.02)
      // top-right curve (slightly flatter)
      ..cubicTo(w * 0.72, -h * 0.04, w * 1.05, h * 0.12, w * 1.02, h * 0.38)
      // right side — protrudes outward
      ..cubicTo(w * 1.00, h * 0.56, w * 1.10, h * 0.72, w * 0.92, h * 0.88)
      // bottom-right point / protrusion
      ..cubicTo(w * 0.80, h * 0.98, w * 0.65, h * 1.06, w * 0.50, h * 1.00)
      // bottom-left curve (pulled inward)
      ..cubicTo(w * 0.28, h * 0.94, w * 0.05, h * 0.88, w * 0.02, h * 0.68)
      // left side
      ..cubicTo(-w * 0.04, h * 0.48, w * 0.04, h * 0.22, w * 0.20, h * 0.10)
      // back to top
      ..cubicTo(w * 0.28, h * 0.04, w * 0.36, h * 0.04, w * 0.48, h * 0.02)
      ..close();
  }

  @override
  bool shouldReclip(_BlobClipper old) => false;
}

// ── Google 'G' icon — official SVG ────────────────────────────────────────

const _kGoogleLogoSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path fill="#4285F4"
    d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04
       2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
  <path fill="#34A853"
    d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23
       1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99
       20.53 7.7 23 12 23z"/>
  <path fill="#FBBC05"
    d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18
       C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
  <path fill="#EA4335"
    d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97
       1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53
       6.16-4.53z"/>
</svg>
''';

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _kGoogleLogoSvg,
      width: 20,
      height: 20,
    );
  }
}
