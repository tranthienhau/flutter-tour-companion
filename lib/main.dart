import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'screens/tour_code_entry_screen.dart';

void main() {
  runApp(const ProviderScope(child: TourCompanionApp()));
}

class TourCompanionApp extends StatelessWidget {
  const TourCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const TourCodeEntryScreen(),
    );
  }
}
