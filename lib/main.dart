import 'package:event_finder/screens/onboarding_screen.dart';
import 'package:event_finder/themes/app_themes.dart';
import 'package:event_finder/themes/theme_notifier.dart';
import 'package:flutter/material.dart';

/// Global key so any widget can access the notifier without
/// needing InheritedWidget / Provider package overhead.
final ThemeNotifier themeNotifier = ThemeNotifier();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Event Finder',
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: themeNotifier.mode,
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
