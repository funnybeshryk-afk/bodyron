import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:bodyron/data/locale_store.dart';
import 'package:bodyron/data/theme_store.dart';
import 'package:bodyron/data/training_program_store.dart';
import 'package:bodyron/main.dart';

void main() {
  // sqflite talks to a native platform channel that doesn't exist in the
  // plain-Dart widget-test host — swap in the FFI (in-memory) backend.
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('Dashboard shows BODYRON header and no-program setup action', (
    WidgetTester tester,
  ) async {
    // showOnboarding: false — this test exercises Dashboard directly, not
    // the mandatory onboarding gate (see main.dart for the real "new user
    // without history" decision).
    await tester.pumpWidget(BodyronApp(
      themeStore: ThemeStore(),
      localeStore: LocaleStore(),
      trainingProgramStore: TrainingProgramStore(),
      showOnboarding: false,
    ));
    await tester.pumpAndSettle();

    expect(find.text('BODYRON'), findsOneWidget);
    // With no active program, Home shows a prominent setup card instead of
    // the old mock card — see TodayWorkoutCard's no-program state.
    expect(find.text('Set up your program in 30 seconds'), findsOneWidget);
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
  });
}
