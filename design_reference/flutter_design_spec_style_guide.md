# MemoryBloom: Flutter Style Guide & Design Specifications

This document provides the technical tokens and layout logic required to translate the **MemoryBloom** design into Flutter.

## 1. Color Palette (Material 3 Mapping)

Use these hex codes in your `ColorScheme`.

| Token | Hex Code | Flutter Property |
| :--- | :--- | :--- |
| **Primary** | `#e8927c` | `colorScheme.primary` |
| **On Primary** | `#ffffff` | `colorScheme.onPrimary` |
| **Surface** | `#fff8f5` | `colorScheme.surface` |
| **On Surface** | `#4a3228` | `colorScheme.onSurface` |
| **Surface Container Low** | `#fdf1ea` | `colorScheme.surfaceContainerLow` |
| **Primary Container** | `#ffdcd2` | `colorScheme.primaryContainer` |
| **On Primary Container** | `#3e0e00` | `colorScheme.onPrimaryContainer` |
| **Secondary (Sage)** | `#56624b` | `colorScheme.secondary` |

## 2. Typography (Literata)

MemoryBloom uses the **Literata** serif font for an emotional, editorial feel.

| Role | Font Size | Weight | Letter Spacing | Flutter `TextStyle` |
| :--- | :--- | :--- | :--- | :--- |
| **Display (Hero)** | 32.0 | Bold | -0.5 | `TextStyle(fontSize: 32, fontWeight: FontWeight.w700)` |
| **Headline (Large)** | 24.0 | Bold | 0.0 | `TextStyle(fontSize: 24, fontWeight: FontWeight.w700)` |
| **Title (Medium)** | 18.0 | SemiBold | 0.1 | `TextStyle(fontSize: 18, fontWeight: FontWeight.w600)` |
| **Body (Large)** | 16.0 | Regular | 0.5 | `TextStyle(fontSize: 16, fontWeight: FontWeight.w400)` |
| **Label (Small)** | 12.0 | Medium | 0.4 | `TextStyle(fontSize: 12, fontWeight: FontWeight.w500)` |

## 3. UI Component Specs

### Global Border Radius
*   **Cards:** `BorderRadius.circular(24.0)`
*   **Buttons (Pill):** `BorderRadius.circular(100.0)`
*   **Photo Thumbnails:** `BorderRadius.circular(24.0)`

### Spacing System
*   **Outer Page Margin:** `16.0` (all sides)
*   **Vertical Stack Spacing:** `24.0` (between major sections)
*   **Grid Gutter:** `12.0` (between photo thumbnails)

### Component Logic
*   **Top App Bar:** Center-aligned title, transparent or surface color, `elevation: 0`.
*   **Floating "Download All" Button:** 
    *   `FloatingActionButton.extended`
    *   Background: `#e8927c`
    *   Shape: `StadiumBorder()`
    *   Shadow: Soft elevation 4.

## 4. Flutter Conversion Prompt for AI Studio

When you export the HTML/CSS to AI Studio, use this prompt for the best results:

> "I have attached the HTML and Tailwind CSS for the MemoryBloom mobile app. Please convert these screens into Flutter Dart code. Use Material 3, follow the provided Literata typography, and map the Tailwind 'terracotta' colors to the Primary color scheme. Create reusable custom widgets for the rounded cards and pill-shaped buttons to match the 24px corner radius in the design."
