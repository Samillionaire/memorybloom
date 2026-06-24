import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_screen.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutlineVariant = Color(0xFFD9C1BC);
const _kPrimaryContainer = Color(0xFFFFDCD2);

/// Navigation drawer for MemoryBloom. Opened from the hamburger menu on Home.
class SidebarDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const SidebarDrawer({
    super.key,
    this.userName = 'sameer',
    this.userEmail = 'sameer15v3@gmail.com',
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.80;
    return Drawer(
      backgroundColor: _kSurface,
      width: width,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: close + logo ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: _kOnSurface),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.local_florist_rounded,
                      color: _kPrimary, size: 26),
                  const SizedBox(width: 8),
                  Text(
                    'MemoryBloom',
                    style: GoogleFonts.literata(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _kPrimaryDeep,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _kOutlineVariant),

            // ── Menu items ─────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _MenuItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    active: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.event_outlined,
                    label: 'My Events',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.photo_library_outlined,
                    label: 'Albums',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.group_outlined,
                    label: 'Shared with Me',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.favorite_outline_rounded,
                    label: 'Favorites',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.print_outlined,
                    label: 'Prints & Templates',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.cloud_sync_outlined,
                    label: 'Backup & Sync',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    onTap: () {
                      Navigator.of(context).pop(); // close drawer
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ProfileScreen()),
                      );
                    },
                  ),
                  _MenuItem(
                    icon: Icons.card_membership_outlined,
                    label: 'Subscription',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _MenuItem(
                    icon: Icons.support_agent_outlined,
                    label: 'Support',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // ── Footer: user ───────────────────────────────────────────
            const Divider(height: 1, color: _kOutlineVariant),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEFA088), Color(0xFFD06A50)],
                      ),
                    ),
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _kOnSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userEmail,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: _kOnSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Menu item ────────────────────────────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: active ? _kPrimaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: active ? _kPrimaryDeep : _kOnSurface,
                ),
                const SizedBox(width: 18),
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: active ? _kPrimaryDeep : _kOnSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
