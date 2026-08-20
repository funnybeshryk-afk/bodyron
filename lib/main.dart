import 'package:flutter/material.dart';

import 'data/theme_store.dart';
import 'database/database_helper.dart';
import 'l10n/app_localizations.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Открывает (и при необходимости создаёт/мигрирует) БД до первого кадра,
  // чтобы стораджи могли грузить сохранённые данные сразу после старта.
  await DatabaseHelper.instance.database;

  // Грузим сохранённый выбор темы до первого кадра, чтобы не мелькнуть
  // системной темой перед тем, как применится сохранённая.
  final themeStore = ThemeStore();
  await themeStore.loadFromDatabase();

  runApp(BodyronApp(themeStore: themeStore));
}

class BodyronApp extends StatelessWidget {
  final ThemeStore themeStore;

  const BodyronApp({super.key, required this.themeStore});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeStore,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BODYRON',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeStore.mode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MainScreen(themeStore: themeStore),
        );
      },
    );
  }
}
