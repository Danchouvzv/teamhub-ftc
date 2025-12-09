import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ftc_teamhub/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: FTCTeamHubApp(),
      ),
    );

    // Verify that the app starts.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
