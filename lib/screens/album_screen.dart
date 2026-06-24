import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Palette (from DESIGN.md tokens) ─────────────────────────────────────────
const _kSurface = Color(0xFFFFF8F5);
const _kPrimary = Color(0xFFE8927C);
const _kPrimaryDeep = Color(0xFF904B39);
const _kOnSurface = Color(0xFF201B17);
const _kOnSurfaceVariant = Color(0xFF54433F);
const _kInverseSurface = Color(0xFF352F2B);
const _kContainerHigh = Color(0xFFF2E6DF);

class AlbumScreen extends StatefulWidget {
  final String eventName;

  const AlbumScreen({super.key, this.eventName = 'Eleanor & James'});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  int _tab = 0;

  static const List<({String label, int count})> _tabs = [
    (label: 'Ceremony', count: 248),
    (label: 'Reception', count: 86),
    (label: 'Haldi', count: 54),
    (label: 'Mehndi', count: 73),
    (label: 'Sangeet', count: 98),
  ];

  // Demo photos for the grid (free Unsplash CDN images).
  static const List<String> _photos = [
    'https://images.unsplash.com/photo-1606800052052-a08af7148866?w=800&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1583939003579-730e3918a45a?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519741497674-611481863552?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1591604466107-ec97de577aff?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1604017011826-d3b4c23f8914?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1465495976277-4387d4b0b4c6?w=600&q=80&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=600&q=80&auto=format&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    final tab = _tabs[_tab];
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top app bar ──────────────────────────────────────────
                _TopBar(
                  title: widget.eventName,
                  onBack: () => Navigator.maybePop(context),
                ),

                // ── Tabs ────────────────────────────────────────────────
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _tabs.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, i) => _TabChip(
                      label: _tabs[i].label,
                      selected: _tab == i,
                      onTap: () => setState(() => _tab = i),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Section header ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tab.label,
                        style: GoogleFonts.literata(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: _kOnSurface,
                        ),
                      ),
                      Text(
                        '${tab.count} photos',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _kOnSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ── Photo grid ──────────────────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    children: [
                      // Hero photo
                      _Photo(url: _photos.first, height: 220),
                      const SizedBox(height: 12),
                      // Two-column grid of the rest
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _photos.length - 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, i) =>
                            _Photo(url: _photos[i + 1]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Floating Download All button ───────────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: _DownloadAllButton(onTap: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Top app bar ──────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  const _TopBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: _kOnSurface),
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _kOnSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab chip ─────────────────────────────────────────────────────────────────

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? _kInverseSurface : _kContainerHigh,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : _kOnSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

// ── Photo tile ───────────────────────────────────────────────────────────────

class _Photo extends StatelessWidget {
  final String url;
  final double? height;

  const _Photo({required this.url, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.network(
        url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : Container(
                height: height,
                color: _kContainerHigh,
                child: const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _kPrimary,
                    ),
                  ),
                ),
              ),
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          color: _kContainerHigh,
          child: const Icon(Icons.broken_image_outlined,
              color: _kOnSurfaceVariant),
        ),
      ),
    );
  }
}

// ── Download All button ──────────────────────────────────────────────────────

class _DownloadAllButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DownloadAllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _kPrimary.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(100),
      elevation: 4,
      shadowColor: _kPrimaryDeep.withValues(alpha: 0.4),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download_rounded, size: 20, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'Download All',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
