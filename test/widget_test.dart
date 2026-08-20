import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:bodyron/data/theme_store.dart';
import 'package:bodyron/main.dart';

void main() {
  // sqflite talks to a native platform channel that doesn't exist in the
  // plain-Dart widget-test host — swap in the FFI (in-memory) backend.
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('Dashboard shows BODYRON header and Start Workout action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(BodyronApp(themeStore: ThemeStore()));
    await tester.pumpAndSettle();

    expect(find.text('BODYRON'), findsOneWidget);
    expect(find.text('Start Workout'), findsOneWidget);
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
  });
}
