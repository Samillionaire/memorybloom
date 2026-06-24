import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutline = Color(0xFF86736E);
const _kContainerHigh = Color(0xFFF2E6DF);
const _kSecondarySage = Color(0xFF56624B);
const _kError = Color(0xFFBA1A1A);

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;

  const ProfileScreen({
    super.key,
    this.name = 'Sameer',
    this.email = 'sameer15v3@gmail.com',
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _pushNotifications = true;
  bool _emailUpdates = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: Column(
        children: [
          _Header(onBack: () => Navigator.maybePop(context)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                Transform.translate(
                  offset: const Offset(0, -28),
                  child: _ProfileCard(name: widget.name, email: widget.email),
                ),

                // ── Personal Information ───────────────────────────────
                _SectionCard(
                  icon: Icons.person_outline_rounded,
                  iconTint: _kPrimary,
                  title: 'Personal Information',
                  children: [
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Name',
                      value: widget.name,
                      editable: true,
                    ),
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone Number',
                      value: '+91 82189 41574',
                      editable: true,
                    ),
                    _InfoRow(
                      icon: Icons.mail_outline_rounded,
                      label: 'Email Address',
                      value: widget.email,
                    ),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: 'Saharanpur, IN',
                      editable: true,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Account Information ────────────────────────────────
                _SectionCard(
                  icon: Icons.badge_outlined,
                  iconTint: const Color(0xFFC8A42C),
                  title: 'Account Information',
                  children: [
                    _InfoRow(
                      icon: Icons.tag_rounded,
                      label: 'User ID',
                      value: 'mb_8f3a21c9',
                    ),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Member Since',
                      value: 'June 2026',
                    ),
                    _PlanRow(),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Preferences ────────────────────────────────────────
                _SectionCard(
                  icon: Icons.tune_rounded,
                  iconTint: _kSecondarySage,
                  title: 'Preferences',
                  children: [
                    _ToggleRow(
                      icon: Icons.notifications_none_rounded,
                      label: 'Push Notifications',
                      subtitle: 'Alerts when guests add photos',
                      value: _pushNotifications,
                      onChanged: (v) =>
                          setState(() => _pushNotifications = v),
                    ),
                    _ToggleRow(
                      icon: Icons.mark_email_unread_outlined,
                      label: 'Email Updates',
                      subtitle: 'Event summaries & news',
                      value: _emailUpdates,
                      onChanged: (v) => setState(() => _emailUpdates = v),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Log out ────────────────────────────────────────────
                _LogOutButton(onTap: () => Navigator.maybePop(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(8, topInset + 8, 16, 36),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB85C42), Color(0xFF8C4230)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
          const SizedBox(width: 4),
          Text(
            'Profile',
            style: GoogleFonts.literata(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Profile card ─────────────────────────────────────────────────────────────

class _ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  const _ProfileCard({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A3228).withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFEFA088), Color(0xFFD06A50)],
              ),
              boxShadow: [
                BoxShadow(
                  color: _kPrimary.withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.literata(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _kOnSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: _kOnSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section card ─────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconTint;
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.icon,
    required this.iconTint,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A3228).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconTint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 22, color: iconTint),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.literata(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: _kOnSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

// ── Info row ─────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool editable;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.editable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 19, color: _kOnSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _kOutline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kOnSurface,
                  ),
                ),
              ],
            ),
          ),
          if (editable)
            IconButton(
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.edit_outlined,
                  size: 19, color: _kPrimaryDeep),
            ),
        ],
      ),
    );
  }
}

// ── Subscription plan row ────────────────────────────────────────────────────

class _PlanRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.card_membership_outlined,
                size: 19, color: _kOnSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _kOutline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Free',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kOnSurface,
                  ),
                ),
              ],
            ),
          ),
          // Upgrade chip
          Material(
            color: _kPrimary,
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Upgrade',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Toggle row ───────────────────────────────────────────────────────────────

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 19, color: _kOnSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kOnSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: _kOutline,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: _kPrimary,
            activeThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

// ── Log out button ───────────────────────────────────────────────────────────

class _LogOutButton extends StatelessWidget {
  final VoidCallback onTap;
  const _LogOutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _kSurface,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: _kError.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout_rounded, size: 19, color: _kError),
              const SizedBox(width: 10),
              Text(
                'Log Out',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _kError,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
