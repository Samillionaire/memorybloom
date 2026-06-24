---
name: Warm Nostalgia
colors:
  surface: '#fff8f5'
  surface-dim: '#e3d8d1'
  surface-bright: '#fff8f5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fdf1ea'
  surface-container: '#f8ece5'
  surface-container-high: '#f2e6df'
  surface-container-highest: '#ece0d9'
  on-surface: '#201b17'
  on-surface-variant: '#54433f'
  inverse-surface: '#352f2b'
  inverse-on-surface: '#faeee7'
  outline: '#86736e'
  outline-variant: '#d9c1bc'
  surface-tint: '#904b39'
  primary: '#904b39'
  on-primary: '#ffffff'
  primary-container: '#e8927c'
  on-primary-container: '#672b1b'
  inverse-primary: '#ffb4a2'
  secondary: '#56624b'
  on-secondary: '#ffffff'
  secondary-container: '#dae7c9'
  on-secondary-container: '#5c6851'
  tertiary: '#735c00'
  on-tertiary: '#ffffff'
  tertiary-container: '#c8a42c'
  on-tertiary-container: '#4c3b00'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbd2'
  primary-fixed-dim: '#ffb4a2'
  on-primary-fixed: '#3a0a01'
  on-primary-fixed-variant: '#733424'
  secondary-fixed: '#dae7c9'
  secondary-fixed-dim: '#becbae'
  on-secondary-fixed: '#141e0c'
  on-secondary-fixed-variant: '#3f4a35'
  tertiary-fixed: '#ffe088'
  tertiary-fixed-dim: '#e9c349'
  on-tertiary-fixed: '#241a00'
  on-tertiary-fixed-variant: '#574500'
  background: '#fff8f5'
  on-background: '#201b17'
  surface-variant: '#ece0d9'
typography:
  display-lg:
    fontFamily: Literata
    fontSize: 42px
    fontWeight: '700'
    lineHeight: 52px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Literata
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Literata
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  caption:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  unit: 8px
  margin-mobile: 24px
  gutter-mobile: 16px
  stack-lg: 48px
  stack-md: 24px
  stack-sm: 12px
---

## Brand & Style
The design system is built on the concept of "Digital Heirloom." It prioritizes emotional resonance over raw utility, transforming a utility-driven task (photo collecting) into a sentimental experience. The brand personality is gentle, hospitable, and sophisticated, avoiding the frantic energy of social media or the cold precision of productivity tools.

The design style is **Modern Tactile**, blending elements of Soft Minimalism with refined skeuomorphic cues. It utilizes high-quality whitespace, organic transitions, and depth that mimics physical layers of paper and film. The interface should feel like an invitation to a shared space, evoking the warmth of a well-kept physical scrapbook.

## Colors
The palette is rooted in Earth tones and organic warmth to ensure the user feels at ease.
- **Primary (#E8927C):** A terracotta-rose used for key emotional triggers and primary interaction points.
- **Secondary (#9BA88D):** A muted sage green for positive feedback, "Live" indicators, and secondary actions.
- **Backgrounds:** The interface avoids pure white (#FFFFFF). Instead, use the base Neutral (#FBEFE8) for main surfaces and a slightly lighter cream (#FFF9F5) for secondary containers.
- **Text:** Primary copy uses a Deep Charcoal-Brown (#2D2624) to maintain high legibility without the harshness of pure black. Secondary copy uses a Warm Stone Grey (#827672).

## Typography
This design system employs a sophisticated pairing of an editorial serif and a friendly, rounded sans-serif.
- **Headers (Literata):** Used for titles, names of memories, and emotional prompts. The medium-high contrast and warm curves of the serif provide an authoritative yet literary feel.
- **Body & UI (Plus Jakarta Sans):** Chosen for its soft, rounded terminals and open apertures, ensuring that even technical UI elements feel approachable and clear.
- **Scale:** High emphasis is placed on hierarchy; titles should feel significantly larger than body text to create an "album cover" effect on every screen.

## Layout & Spacing
The layout follows a **Fluid Margin** model with a heavy emphasis on "Breathing Room." 
- **Margins:** Standard mobile screens utilize a generous 24px side margin to frame content, mimicking the border of a photograph.
- **Vertical Rhythm:** A loose vertical rhythm is encouraged. Do not crowd elements; use `stack-lg` (48px) to separate distinct sections or "chapters" of the user journey.
- **Safe Zones:** Content should never feel cramped against the edges of the device. High-priority imagery should be presented with internal padding within its container to maintain the "matted photo" aesthetic.

## Elevation & Depth
Depth is created through **Tonal Stacking** and **Ambient Shadows** rather than high-contrast lines.
- **Surfaces:** Use subtle shifts in background color to define depth. A card may sit on a #FBEFE8 background with a #FFF9F5 fill.
- **Shadows:** Shadows are extremely diffused (Blur: 20px-40px) with low opacity (8-12%) and a slight warm tint (#4A3228). This avoids a "floating" look and instead creates a "resting" look, as if paper is lying on a soft surface.
- **Glassmorphism:** Use subtle backdrop blurs (10px) on navigation bars and overlays to maintain a sense of context and continuity with the photos beneath.

## Shapes
The shape language is organic and soft.
- **Global Radius:** Use a pill-shaped (100px) approach for all interactive buttons.
- **Containers:** Large containers like image cards and modals use a `rounded-xl` (24px) radius to feel friendly and safe.
- **Interactive Small Elements:** Checkboxes and small toggles should be fully rounded to maintain consistency with the primary button style.

## Components
- **Buttons:** Primary buttons use a soft linear gradient (Primary to a slightly lighter tint) with a subtle drop shadow. Labels should be conversational (e.g., "Gather Memories" instead of "Upload").
- **Cards:** Content cards feature high-quality imagery with 24px corner radii. Text is never placed directly over complex imagery without a soft gradient overlay or a separate cream-colored footer area.
- **Input Fields:** Use a 1px border in a warm-grey tone. The focus state shifts the border to the Primary color and adds a soft glow. Fields should have 16px internal padding.
- **Chips & Tags:** Small, fully-rounded capsules used for event categories or status. Use Secondary (#9BA88D) for positive states like "Live" or "Shared."
- **Empty States:** Instead of generic icons, use stylized line-art or soft-focus photography to encourage the user to "Start a New Chapter."
- **Lists:** Lists should be spaced generously with 1px warm-grey dividers that do not touch the screen edges, creating a "floating" look.