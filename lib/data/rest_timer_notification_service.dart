import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/app_localizations_en.dart';

/// Планирует локальное OS-уведомление на момент завершения таймера отдыха,
/// чтобы пользователь получил его, даже если приложение свёрнуто или экран
/// выключен. Дополняет (не заменяет) внутриигровой баннер и вибрацию —
/// см. [WorkoutSessionStore._finishRestTimer], который отменяет уведомление,
/// если таймер естественно завершился при активном приложении.
///
/// Локализация уведомления пока жёстко на английском (см. [AppLocalizationsEn])
/// — планирование идёт из фонового контекста без BuildContext, а
/// в приложении сейчас поддерживается только en (см. l10n-скелет).
class RestTimerNotificationService {
  RestTimerNotificationService._();

  static final RestTimerNotificationService instance = RestTimerNotificationService._();

  static const int _notificationId = 9001;
  static const String _channelId = 'rest_timer';
  static const String _channelName = 'Rest Timer';
  static const String _channelDescription = 'Notifies you when your rest timer finishes.';

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _permissionRequested = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    _initialized = true;

    tz_data.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      settings: const InitializationSettings(android: androidInit),
    );

    const channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Запрашивает разрешение на уведомления (нужно на Android 13+).
  /// Вызывается лениво при первом использовании таймера отдыха, а не при
  /// старте приложения.
  Future<void> ensurePermission() async {
    await _ensureInitialized();
    if (_permissionRequested || !Platform.isAndroid) return;
    _permissionRequested = true;

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleRestComplete(int secondsFromNow) async {
    await _ensureInitialized();

    final l10n = AppLocalizationsEn();
    final scheduledDate = tz.TZDateTime.from(
      DateTime.now().add(Duration(seconds: secondsFromNow)),
      tz.local,
    );

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        category: AndroidNotificationCategory.alarm,
      ),
    );

    try {
      await _plugin.zonedSchedule(
        id: _notificationId,
        title: l10n.restTimerNotificationTitle,
        body: l10n.restTimerNotificationBody,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (_) {
      // Точные будильники недоступны (например, разрешение отозвано в
      // настройках) — планируем неточно; уведомление всё ещё придёт,
      // возможно с небольшой задержкой под Doze.
      await _plugin.zonedSchedule(
        id: _notificationId,
        title: l10n.restTimerNotificationTitle,
        body: l10n.restTimerNotificationBody,
        scheduledDate: scheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }

  Future<void> cancel() async {
    if (!_initialized) return;
    await _plugin.cancel(id: _notificationId);
  }
}
