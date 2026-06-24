import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ready_to_share.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kOutlineVariant = Color(0xFFD9C1BC);
const _kSageContainer = Color(0xFFDAE7C9);
const _kSageText = Color(0xFF3F4A35);

const _kHeaderBgUrl =
    'https://images.unsplash.com/photo-1519225421980-715cb0215aed?w=900&q=80&auto=format&fit=crop';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _eventType = 1; // 0 = Single Event, 1 = Wedding & Multi-Day
  final Set<String> _selectedRituals = {'Haldi', 'Mehndi'};
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // ── Header with faded backdrop + back button + title ───────────
          _Header(onBack: () => Navigator.maybePop(context)),

          // ── Scrollable form ────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              children: [
                // Event type cards
                Row(
                  children: [
                    Expanded(
                      child: _TypeCard(
                        icon: Icons.local_florist_outlined,
                        label: 'Single Event',
                        selected: _eventType == 0,
                        onTap: () => setState(() => _eventType = 0),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _TypeCard(
                        icon: Icons.collections_rounded,
                        label: 'Wedding &\nMulti-Day',
                        selected: _eventType == 1,
                        onTap: () => setState(() => _eventType = 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Event Name
                const _FieldLabel('Event Name'),
                const SizedBox(height: 10),
                _InputField(
                  hint: "e.g. Aarav & Priya's Wedding",
                  controller: _nameController,
                ),
                const SizedBox(height: 24),

                // Expected Guest Count
                const _FieldLabel('Expected Guest Count'),
                const SizedBox(height: 2),
                Text(
                  'Helps us know how your event is doing',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _kPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                const _InputField(
                  hint: 'e.g. 150',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),

                // Events Included
                const _FieldLabel('Events Included'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _RitualChip(
                      label: 'Haldi',
                      icon: Icons.spa_rounded,
                      selected: _selectedRituals.contains('Haldi'),
                      onTap: () => _toggleRitual('Haldi'),
                    ),
                    _RitualChip(
                      label: 'Mehndi',
                      icon: Icons.brush_rounded,
                      selected: _selectedRituals.contains('Mehndi'),
                      onTap: () => _toggleRitual('Mehndi'),
                    ),
                    _RitualChip(
                      label: 'Sangeet',
                      icon: Icons.music_note_rounded,
                      selected: _selectedRituals.contains('Sangeet'),
                      onTap: () => _toggleRitual('Sangeet'),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // Create Event button
                _CreateButton(
                  onPressed: () {
                    final name = _nameController.text.trim();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReadyToShareScreen(
                          eventName:
                              name.isEmpty ? "Eleanor's Garden Gala" : name,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleRitual(String name) {
    setState(() {
      if (_selectedRituals.contains(name)) {
        _selectedRituals.remove(name);
      } else {
        _selectedRituals.add(name);
      }
    });
  }
}

// ── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  const _Header({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topInset + 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Faded photo backdrop
          Image.network(
            _kHeaderBgUrl,
            fit: BoxFit.cover,
            color: _kSurface.withValues(alpha: 0.80),
            colorBlendMode: BlendMode.lighten,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: const Color(0xFFF2E6DF)),
          ),
          // Fade into surface at the bottom
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, _kSurface],
                stops: [0.45, 1.0],
              ),
            ),
          ),
          // Back button + title
          Padding(
            padding: EdgeInsets.fromLTRB(16, topInset + 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CircleIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: onBack,
                ),
                const SizedBox(height: 16),
                Text(
                  "Let's create\nyour event",
                  style: GoogleFonts.literata(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    color: _kOnSurface,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      color: Colors.white.withValues(alpha: 0.75),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(icon, size: 22, color: _kOnSurface),
        ),
      ),
    );
  }
}

// ── Event type card ─────────────────────────────────────────────────────────

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kPrimary : _kOutlineVariant,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kPrimary.withValues(alpha: 0.20),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Icon disc
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? null : const Color(0xFFF2E6DF),
                gradient: selected
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFEFA088), Color(0xFFD06A50)],
                      )
                    : null,
              ),
              child: Icon(
                icon,
                size: 26,
                color: selected ? Colors.white : _kOnSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: _kOnSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Field label ─────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: _kPrimaryDeep,
      ),
    );
  }
}

// ── Input field ─────────────────────────────────────────────────────────────

class _InputField extends StatelessWidget {
  final String hint;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  const _InputField({required this.hint, this.keyboardType, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        color: _kOnSurface,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          color: const Color(0xFFAD9A93),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _kOutlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _kPrimary, width: 1.5),
        ),
      ),
    );
  }
}

// ── Ritual chip ─────────────────────────────────────────────────────────────

class _RitualChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RitualChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? _kSageContainer : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: selected ? _kSageContainer : _kOutlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? _kSageText : _kOnSurfaceVariant,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected ? _kSageText : _kOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Create Event button ─────────────────────────────────────────────────────

class _CreateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CreateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 58,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFEFA088), Color(0xFFB85C42)],
          ),
          boxShadow: [
            BoxShadow(
              color: _kPrimary.withValues(alpha: 0.40),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create Event',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_rounded,
                size: 20, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
