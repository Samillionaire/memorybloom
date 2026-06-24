import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'album_screen.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutlineVariant = Color(0xFFD9C1BC);
const _kContainerLow = Color(0xFFFDF1EA);
const _kContainerHigh = Color(0xFFF2E6DF);

class EventOverviewScreen extends StatefulWidget {
  final String eventName;
  final String date;
  final String location;
  final String imageUrl;

  const EventOverviewScreen({
    super.key,
    this.eventName = 'Eleanor & James',
    this.date = 'SEPT 14, 2024',
    this.location = 'The Botanical Gardens',
    this.imageUrl =
        'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=900&q=80&auto=format&fit=crop',
  });

  @override
  State<EventOverviewScreen> createState() => _EventOverviewScreenState();
}

class _EventOverviewScreenState extends State<EventOverviewScreen> {
  int _tab = 0;
  bool _autoApprove = true;

  // Sub-events / sessions within this event. Easy to extend — add an entry.
  static const List<({String label, int count})> _tabs = [
    (label: 'Ceremony', count: 142),
    (label: 'Reception', count: 86),
    (label: 'Haldi', count: 54),
    (label: 'Mehndi', count: 73),
    (label: 'Sangeet', count: 98),
    (label: 'After Party', count: 31),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Hero(
            eventName: widget.eventName,
            date: widget.date,
            location: widget.location,
            imageUrl: widget.imageUrl,
            onBack: () => Navigator.maybePop(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tabs (horizontally scrollable)
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tabs.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, i) => _TabChip(
                      label: _tabs[i].label,
                      count: _tabs[i].count,
                      selected: _tab == i,
                      onTap: () => setState(() => _tab = i),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Stat cards
                Row(
                  children: const [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.photo_library_outlined,
                        value: '248',
                        label: 'Photos',
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.groups_outlined,
                        value: '62',
                        label: 'Guests',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Auto-Approve
                _AutoApproveCard(
                  value: _autoApprove,
                  onChanged: (v) => setState(() => _autoApprove = v),
                ),
                const SizedBox(height: 24),

                // Actions
                _FilledButton(
                  icon: Icons.visibility_outlined,
                  label: 'View Photos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlbumScreen(eventName: widget.eventName),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _OutlineButton(
                  icon: Icons.tune_rounded,
                  label: 'Moderate Photos',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero header ──────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  final String eventName;
  final String date;
  final String location;
  final String imageUrl;
  final VoidCallback onBack;

  const _Hero({
    required this.eventName,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: topInset + 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Container(color: const Color(0xFF2A2320)),
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFF2A2320)),
            ),
            // Dark gradient for legible overlay text
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x33000000),
                    Colors.transparent,
                    Color(0xCC000000),
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
            // Back button
            Positioned(
              top: topInset + 12,
              left: 16,
              child: _CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: onBack,
              ),
            ),
            // Event meta
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    eventName,
                    style: GoogleFonts.literata(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 5),
                      Text(
                        location,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
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
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.30),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

// ── Tab chip ─────────────────────────────────────────────────────────────────

class _TabChip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? _kPrimary : _kContainerHigh,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : _kOnSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: 0.30)
                    : Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '$count',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : _kOnSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat card ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      decoration: BoxDecoration(
        color: _kContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _kContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: _kPrimaryDeep),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.literata(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _kOnSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _kOnSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Auto-Approve card ────────────────────────────────────────────────────────

class _AutoApproveCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AutoApproveCard({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kOutlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined,
              size: 22, color: _kPrimaryDeep),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto-Approve',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kOnSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Photos appear instantly — perfect for '
                  'casual gatherings where trust is high.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                    color: _kOnSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
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

// ── Buttons ──────────────────────────────────────────────────────────────────

class _FilledButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilledButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFB85C42), Color(0xFF8C4230)],
          ),
          boxShadow: [
            BoxShadow(
              color: _kPrimaryDeep.withValues(alpha: 0.30),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: _kPrimary, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: _kPrimaryDeep),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _kPrimaryDeep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
