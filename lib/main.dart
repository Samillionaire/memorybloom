import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/onboardingScreens/onboarding_flow.dart';

void main() {
  runApp(const MemoryBloomApp());
}

class MemoryBloomApp extends StatelessWidget {
  const MemoryBloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoryBloom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8927C),
          surface: const Color(0xFFFFF8F5),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingFlow(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
