import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bodyron/data/body_weight_store.dart';
import 'package:bodyron/data/training_program_store.dart';
import 'package:bodyron/data/workout_session_store.dart';
import 'package:bodyron/l10n/app_localizations.dart';
import 'package:bodyron/screens/dashboard_screen.dart';
import 'package:bodyron/theme/app_theme.dart';
import 'package:bodyron/widgets/section_title.dart';

/// Проверки, которые раньше делались живым прогоном на устройстве: шапка
/// Dashboard без иконки профиля и весь контент от заголовка до Weekly Progress
/// без скролла.
///
/// Экран пампится напрямую (без MainScreen/БД) — dashboard-у для рендера
/// достаточно свежих, не загруженных из БД стораджей, а лишняя обвязка
/// (несколько параллельных подключений к sqflite, таймеры) в этом файле не
/// нужна и только источник флаки-тестов.
///
/// По умолчанию flutter_test рисует каждый глиф квадратом в размер шрифта, из-за
/// чего текст примерно в 1.7 раза шире реального и высота вёрстки завышена. Тут
/// подгружается настоящий Roboto из кэша Flutter SDK — тогда замеры совпадают с
/// тем, что видно на телефоне.
void main() {
  setUpAll(() async {
    await _loadRoboto();
  });

  /// Логические размеры типовых телефонов. compact 360x780 близок к ABR LX1,
  /// на котором проверялась исходная задача.
  const phoneSizes = <String, Size>{
    'compact 360x780': Size(360, 780),
    'typical 393x851': Size(393, 851),
    'large 412x915': Size(412, 915),
  };

  Future<void> pumpDashboardAt(WidgetTester tester, Size logicalSize) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = logicalSize;
    addTearDown(tester.view.reset);

    final theme = AppTheme.light;
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          textTheme: theme.textTheme.apply(fontFamily: _robotoFamily),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DashboardScreen(
            store: WorkoutSessionStore(),
            bodyWeightStore: BodyWeightStore(),
            trainingProgramStore: TrainingProgramStore(),
            onStartProgramDay: (_) {},
            onSetupProgram: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  ScrollableState dashboardScrollable(WidgetTester tester) {
    return tester.state<ScrollableState>(find.byType(Scrollable));
  }

  group('Dashboard header', () {
    testWidgets('has no profile avatar/icon duplicating the Profile tab', (
      tester,
    ) async {
      await pumpDashboardAt(tester, const Size(393, 851));

      expect(find.byType(CircleAvatar), findsNothing);

      for (final icon in [
        Icons.person,
        Icons.person_outline,
        Icons.person_rounded,
        Icons.account_circle,
        Icons.account_circle_outlined,
      ]) {
        expect(
          find.byIcon(icon),
          findsNothing,
          reason: 'Dashboard still renders a profile icon ($icon)',
        );
      }

      // Заголовок и подзаголовок при этом на месте.
      expect(find.text('BODYRON'), findsOneWidget);
    });
  });

  group('Dashboard fits on one screen', () {
    for (final entry in phoneSizes.entries) {
      testWidgets('no scrolling needed on ${entry.key}', (tester) async {
        await pumpDashboardAt(tester, entry.value);

        final position = dashboardScrollable(tester).position;
        expect(
          position.maxScrollExtent,
          0.0,
          reason:
              'Dashboard needs ${position.maxScrollExtent.toStringAsFixed(1)}px '
              'more height on ${entry.key} — Weekly Progress is below the fold',
        );
      });
    }

    testWidgets('Weekly Progress card is fully visible', (tester) async {
      await pumpDashboardAt(tester, const Size(393, 851));

      // Секция присутствует...
      expect(
        find.widgetWithText(SectionTitle, 'WEEKLY PROGRESS'),
        findsOneWidget,
      );

      // ...и её нижний край не уходит за нижнюю границу вьюпорта.
      final viewportBottom = tester.getRect(find.byType(DashboardScreen)).bottom;
      final contentBottom =
          tester.getRect(find.byType(SingleChildScrollView)).bottom;

      expect(dashboardScrollable(tester).position.maxScrollExtent, 0.0);
      expect(contentBottom, lessThanOrEqualTo(viewportBottom + 0.5));
    });
  });

  group('No layout overflow', () {
    for (final entry in phoneSizes.entries) {
      testWidgets('renders without overflow on ${entry.key}', (tester) async {
        await pumpDashboardAt(tester, entry.value);
        expect(tester.takeException(), isNull);
      });
    }
  });
}

const _robotoFamily = 'Roboto';

/// Roboto лежит в кэше Flutter SDK рядом с dart-sdk, из которого запущен тест,
/// поэтому путь выводится из [Platform.resolvedExecutable] — ничего не нужно
/// коммитить в репозиторий и путь не привязан к конкретной машине.
Future<void> _loadRoboto() async {
  // Тест исполняется flutter_tester'ом из глубины <flutter>/bin/cache, поэтому
  // просто поднимаемся вверх, пока не найдём artifacts/material_fonts.
  Directory? fontsDir;
  for (
    var dir = File(Platform.resolvedExecutable).parent;
    dir.path != dir.parent.path;
    dir = dir.parent
  ) {
    final candidate = Directory('${dir.path}/artifacts/material_fonts');
    if (candidate.existsSync()) {
      fontsDir = candidate;
      break;
    }
  }

  if (fontsDir == null) {
    fail(
      'Roboto not found under the Flutter SDK cache — layout measurements '
      'would use the placeholder test font and overstate the real height.',
    );
  }

  final loader = FontLoader(_robotoFamily);
  for (final name in const [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-black.ttf',
  ]) {
    final file = File('${fontsDir.path}/$name');
    if (file.existsSync()) {
      loader.addFont(
        file.readAsBytes().then((b) => ByteData.view(b.buffer)),
      );
    }
  }
  await loader.load();
}
