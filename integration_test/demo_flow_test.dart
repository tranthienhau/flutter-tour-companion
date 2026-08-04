import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

import 'package:tour_companion/main.dart';

/// A real-time walkthrough used only to record the demo GIF. Dwells on each
/// screen (wall-clock delays) so the recording is watchable.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> dwell(WidgetTester tester, [int ms = 1100]) async {
    final end = DateTime.now().add(Duration(milliseconds: ms));
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 60));
    }
  }

  Future<void> tapText(WidgetTester tester, String label,
      {bool last = false}) async {
    final f = find.text(label);
    await tester.tap(last ? f.last : f.first);
    for (int i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 40));
    }
  }

  testWidgets('demo walkthrough', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TourCompanionApp()));
    await dwell(tester, 1400); // 01 tour code

    await tapText(tester, 'Continue');
    await dwell(tester, 1400); // 02 welcome

    await tapText(tester, 'Enter app');
    await dwell(tester, 1600); // 03 home

    await tapText(tester, 'Full day');
    await dwell(tester, 1400); // 05 day detail
    await tapText(tester, 'Ashes Test - Day 1', last: true);
    await dwell(tester, 1500); // 06 activity detail

    // back to home
    await tester.pageBack();
    await dwell(tester, 500);
    await tester.pageBack();
    await dwell(tester, 700);

    await tapText(tester, 'Itinerary', last: true);
    await dwell(tester, 1500); // 04 itinerary

    await tapText(tester, 'Map', last: true);
    await dwell(tester, 1500); // 08 map

    await tapText(tester, 'Updates', last: true);
    await dwell(tester, 1500); // 09 updates

    await tapText(tester, 'Profile', last: true);
    await dwell(tester, 1600); // 11 profile
  });
}
