# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

`memorybloom` is a Flutter application targeting Android, iOS, web, Windows, macOS, and Linux.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app (pick a target device)
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Analyze for lint/type errors
flutter analyze

# Build release APK
flutter build apk

# Build for web
flutter build web
```

## Architecture

Currently a single-file app in `lib/main.dart` (Flutter's default counter scaffold). As features are added, the conventional Flutter structure to follow is:

- `lib/` — all Dart source code
  - `main.dart` — app entry point, `MaterialApp` setup
  - `screens/` or `pages/` — full-screen widgets
  - `widgets/` — reusable UI components
  - `models/` — data classes
  - `services/` — business logic, data fetching, persistence

State management and routing patterns should be decided and documented here as they are introduced.

## Linting

Lint rules come from `package:flutter_lints/flutter.yaml` (configured in `analysis_options.yaml`). Run `flutter analyze` to check before committing.
