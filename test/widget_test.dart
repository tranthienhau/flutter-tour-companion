import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tour_companion/main.dart';

void main() {
  testWidgets('Tour code entry renders', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TourCompanionApp()));
    expect(find.text('Enter your tour code'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
