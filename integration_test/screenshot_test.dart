import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

import 'package:tour_companion/main.dart';
import 'package:tour_companion/screens/home_shell.dart';
import 'package:tour_companion/screens/day_detail_screen.dart';
import 'package:tour_companion/screens/activity_detail_screen.dart';
import 'package:tour_companion/screens/hotels_transfers_screen.dart';
import 'package:tour_companion/state/providers.dart';
import 'package:tour_companion/data/mock_data.dart';

/// Drives the running app across the key screens and captures a PNG per screen.
/// Uses fixed pumps (not pumpAndSettle) so gradient/animation screens settle.
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> shot(WidgetTester tester, String name) async {
    await binding.convertFlutterSurfaceToImage();
    await tester.pump(const Duration(milliseconds: 400));
    await binding.takeScreenshot(name);
  }

  testWidgets('capture all screens', (tester) async {
    // 01 - Tour code entry
    await tester.pumpWidget(const ProviderScope(child: TourCompanionApp()));
    await tester.pump(const Duration(seconds: 1));
    await shot(tester, '01-tour-code-entry');

    // 02 - Welcome group
    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(milliseconds: 700));
    await shot(tester, '02-welcome-group');

    // Enter app -> Home shell (03)
    await tester.tap(find.text('Enter app'));
    await tester.pump(const Duration(milliseconds: 700));
    await shot(tester, '03-home');

    // 04 - Itinerary tab
    await tester.tap(find.text('Itinerary').last);
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '04-itinerary');

    // 08 - Map tab
    await tester.tap(find.text('Map').last);
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '08-map-directions');

    // 09 - Updates tab
    await tester.tap(find.text('Updates').last);
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '09-updates');

    // 11 - Profile tab
    await tester.tap(find.text('Profile').last);
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '11-profile');
  });

  testWidgets('capture pushed detail screens', (tester) async {
    final container = ProviderContainer();
    container.read(tourProvider.notifier).state = kGroupC;
    final today =
        kGroupC.itinerary.firstWhere((d) => d.status.name == 'today');

    // 05 - Day detail
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: DayDetailScreen(day: today),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '05-day-detail');

    // 06 - Activity detail (the match)
    final match =
        today.activities.firstWhere((a) => a.category == 'Match');
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: ActivityDetailScreen(activity: match),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '06-activity-detail');

    // 07 - Hotels and transfers
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const HotelsTransfersScreen()),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '07-hotels-transfers');

    // 10 - Updates empty
    container.read(updatesProvider.notifier).clearAll();
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const HomeShell(initialIndex: 3)),
    ));
    await tester.pump(const Duration(milliseconds: 500));
    await shot(tester, '10-updates-empty');
  });
}
