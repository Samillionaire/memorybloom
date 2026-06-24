import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutlineVariant = Color(0xFFD9C1BC);
const _kSageContainer = Color(0xFFDAE7C9);
const _kSageText = Color(0xFF3F4A35);
const _kPeachContainer = Color(0xFFFAD9CE);

class ReadyToShareScreen extends StatelessWidget {
  final String eventName;

  const ReadyToShareScreen({super.key, this.eventName = "Eleanor's Garden Gala"});

  /// The unique link for this event (also encoded in the QR code).
  String get _eventLink =>
      'https://memorybloom.app/e/${Uri.encodeComponent(eventName)}';

  /// Opens WhatsApp with a pre-filled invite message + unique event link.
  Future<void> _shareViaWhatsApp(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final message =
        "You're invited to '$eventName' on MemoryBloom! 🎉\n"
        'Scan or tap to share your photos — no app needed:\n$_eventLink';
    final encoded = Uri.encodeComponent(message);

    // Try the WhatsApp app scheme first, then fall back to the wa.me web link.
    final candidates = <Uri>[
      Uri.parse('whatsapp://send?text=$encoded'),
      Uri.parse('https://wa.me/?text=$encoded'),
    ];

    // Attempt each candidate directly. We do NOT use canLaunchUrl() as a gate
    // because on Android 11+ it can return false even when the launch succeeds.
    for (final uri in candidates) {
      try {
        final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (ok) return;
      } catch (_) {
        // Try the next candidate.
      }
    }

    messenger.showSnackBar(
      const SnackBar(
        content: Text('WhatsApp isn’t available on this device.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            const SizedBox(height: 12),

            // ── Celebration icon ───────────────────────────────────────
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFEFA088), Color(0xFFD06A50)],
                  ),
                ),
                child: const Icon(
                  Icons.celebration_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Title ──────────────────────────────────────────────────
            Text(
              'Your event is ready!',
              textAlign: TextAlign.center,
              style: GoogleFonts.literata(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: _kPrimaryDeep,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            const Center(child: Text('🎉', style: TextStyle(fontSize: 22))),
            const SizedBox(height: 24),

            // ── QR card ────────────────────────────────────────────────
            _QrCard(eventName: eventName),
            const SizedBox(height: 20),

            // ── Caption ────────────────────────────────────────────────
            Text(
              'Guests scan this to share their photos\n— no app needed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: _kOnSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            // ── Action buttons ─────────────────────────────────────────
            _FilledPillButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Share via WhatsApp',
              background: _kSageContainer,
              foreground: _kSageText,
              onTap: () => _shareViaWhatsApp(context),
            ),
            const SizedBox(height: 12),
            _FilledPillButton(
              icon: Icons.download_rounded,
              label: 'Download Printable Template',
              background: _kPeachContainer,
              foreground: _kPrimaryDeep,
              onTap: () {},
            ),
            const SizedBox(height: 20),

            const Divider(color: _kOutlineVariant, height: 1),

            // ── Copy links ─────────────────────────────────────────────
            _CopyLinkRow(label: 'Copy Slideshow Link', onTap: () {}),
            const Divider(color: _kOutlineVariant, height: 1),
            _CopyLinkRow(label: 'Copy Moderator Link', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

// ── QR card ──────────────────────────────────────────────────────────────────

class _QrCard extends StatelessWidget {
  final String eventName;
  const _QrCard({required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A3228).withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Layered light frame with a folded corner + tilted QR tile
          SizedBox(
            width: 240,
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Large light backing frame (clipped) with folded corner
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    children: [
                      Container(
                        width: 240,
                        height: 240,
                        color: const Color(0xFFF4EDE6),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CustomPaint(
                          size: const Size(40, 40),
                          painter: _FoldedCornerPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Inner nested frame for added depth
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF6F0),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A3228).withValues(alpha: 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                // Raised, slightly tilted white QR tile
                Transform.rotate(
                  angle: -0.06, // ≈ -3.4° tilt
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF4A3228).withValues(alpha: 0.18),
                          blurRadius: 22,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data:
                          'https://memorybloom.app/e/${Uri.encodeComponent(eventName)}',
                      version: QrVersions.auto,
                      size: 130,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color(0xFF201B17),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color(0xFF201B17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            eventName,
            style: GoogleFonts.literata(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _kOnSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Folded page-corner (dog-ear) ─────────────────────────────────────────────

class _FoldedCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Folded flap occupies the top-right triangle: (0,0)→(w,0)→(w,h).
    // The underside of the page reads as a lighter cream against the frame.
    final fold = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(fold, Paint()..color = const Color(0xFFEDE3DA));

    // Soft shadow line along the fold crease for a paper-like lift.
    canvas.drawLine(
      Offset(0, 0),
      Offset(w, h),
      Paint()
        ..color = const Color(0xFF4A3228).withValues(alpha: 0.10)
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_FoldedCornerPainter old) => false;
}

// ── Filled pill button ───────────────────────────────────────────────────────

class _FilledPillButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  const _FilledPillButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 19, color: foreground),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Copy link row ────────────────────────────────────────────────────────────

class _CopyLinkRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CopyLinkRow({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _kOnSurface,
              ),
            ),
            const Icon(Icons.copy_rounded, size: 19, color: _kOnSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
