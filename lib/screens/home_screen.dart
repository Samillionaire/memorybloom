import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_event_screen.dart';
import 'event_overview_screen.dart';
import 'profile_screen.dart';
import 'sidebar_screen.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutline = Color(0xFF86736E);
const _kSecondarySage = Color(0xFF56624B);

// ── Network image URLs (free-to-use Unsplash CDN photos) ────────────────────
const _kAvatarUrl =
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80&auto=format&fit=crop';
const _kSummerUrl =
    'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=900&q=80&auto=format&fit=crop';
const _kWeddingUrl =
    'https://images.unsplash.com/photo-1519741497674-611481863552?w=900&q=80&auto=format&fit=crop';

/// A network image with a warm placeholder while loading and a coloured
/// fallback if the fetch fails (offline, etc.).
class _NetworkImg extends StatelessWidget {
  final String url;
  final Color fallback;
  final Widget? fallbackChild;

  const _NetworkImg({
    required this.url,
    required this.fallback,
    this.fallbackChild,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: fallback,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white70,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          Container(color: fallback, child: fallbackChild),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      drawer: const SidebarDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: const [
                  _Greeting(),
                  SizedBox(height: 24),
                  _CreateEventCard(),
                  SizedBox(height: 28),
                  _SectionHeader(),
                  SizedBox(height: 16),
                  _EventCard(
                    imageUrl: _kSummerUrl,
                    title: "Summer Retreat '24",
                    memories: '142 Memories',
                    status: _EventStatus.live,
                    fallback: Color(0xFF3B4A3A),
                  ),
                  SizedBox(height: 16),
                  _EventCard(
                    imageUrl: _kWeddingUrl,
                    title: "Anna & David's Wedding",
                    memories: '850 Memories',
                    status: _EventStatus.completed,
                    fallback: Color(0xFF4A3A3A),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

// ── Top app bar ─────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, color: _kOnSurface),
          ),
          Expanded(
            child: Center(
              child: Text(
                'MemoryBloom',
                style: GoogleFonts.literata(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _kPrimaryDeep,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE8C9A8),
                border: Border.all(color: const Color(0xFFD9C1BC), width: 1),
              ),
              clipBehavior: Clip.antiAlias,
              child: const _NetworkImg(
                url: _kAvatarUrl,
                fallback: Color(0xFFE8C9A8),
                fallbackChild: Icon(
                  Icons.person_rounded,
                  size: 22,
                  color: Color(0xFF8A6A4A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Greeting ────────────────────────────────────────────────────────────────

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good evening, Sam',
          style: GoogleFonts.literata(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: _kOnSurface,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ready to gather some memories?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: _kOnSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ── Create New Event card ───────────────────────────────────────────────────

class _CreateEventCard extends StatelessWidget {
  const _CreateEventCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreateEventScreen()),
      ),
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD9B8), Color(0xFFF8B79A)],
        ),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.add_rounded, size: 26, color: _kPrimaryDeep),
          ),
          const SizedBox(height: 16),
          Text(
            'Create New Event',
            style: GoogleFonts.literata(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF5C2E1E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Start a new chapter in your journal.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF7A4030),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

// ── "Your Events" section header ────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Your Events',
          style: GoogleFonts.literata(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _kOnSurface,
          ),
        ),
        Text(
          'View all',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _kPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Event card ──────────────────────────────────────────────────────────────

enum _EventStatus { live, completed }

class _EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String memories;
  final _EventStatus status;
  final Color fallback;

  const _EventCard({
    required this.imageUrl,
    required this.title,
    required this.memories,
    required this.status,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EventOverviewScreen(
            eventName: title,
            imageUrl: imageUrl,
          ),
        ),
      ),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background photo
            _NetworkImg(url: imageUrl, fallback: fallback),
            // Dark gradient overlay for legible text
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            // Status badge
            Positioned(top: 14, right: 14, child: _StatusBadge(status: status)),
            // Title + memories
            Positioned(
              left: 18,
              right: 18,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.literata(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.photo_library_rounded,
                        size: 15,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        memories,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final _EventStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isLive = status == _EventStatus.live;
    final bg = isLive ? _kSecondarySage : const Color(0xFFE8E0D8);
    final fg = isLive ? Colors.white : const Color(0xFF54433F);
    final label = isLive ? 'Live' : 'Completed';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLive) ...[
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom navigation ───────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kSurface,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A3228).withValues(alpha: 0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const _NavItem(
                icon: Icons.home_rounded, label: 'Home', active: true),
            _NavItem(
              icon: Icons.calendar_today_rounded,
              label: 'Event',
              active: false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EventOverviewScreen()),
              ),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'Profile',
              active: false,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: _kPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: _kOutline),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: _kOutline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
