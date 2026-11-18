import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Acción "Posponer" de las notificaciones de recordatorio.
const String snoozeActionId = 'snooze';
const String _categoryId = 'hydration_reminder';

/// Se ejecuta en un isolate aparte cuando el usuario pulsa "Posponer" con la
/// app cerrada o en segundo plano.
@pragma('vm:entry-point')
Future<void> notificationBackgroundHandler(NotificationResponse response) async {
  if (response.actionId != snoozeActionId) return;
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final service = NotificationService();
  await service.init();
  await service.scheduleSnooze(NotificationService.snoozeMinutesFrom(response.payload));
}

/// Envoltorio de flutter_local_notifications para los recordatorios.
///
/// Los instantes se programan en UTC a partir de horas locales ya resueltas
/// por Dart, de modo que no hace falta conocer el identificador de zona
/// horaria del dispositivo y el horario de verano queda cubierto.
class NotificationService {
  NotificationService([FlutterLocalNotificationsPlugin? plugin]) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  static const int reminderBaseId = 1000;
  static const int maxReminderSlots = 64;
  static const int snoozeId = 2000;
  static const int testId = 2001;

  static const _messages = [
    ('Hora de un sorbo', 'Aqua te recuerda beber un poco de agua.'),
    ('¿Un vaso de agua?', 'Tu cuerpo te lo agradecerá. Aqua también.'),
    ('Aqua tiene sed', 'Registra tu próximo vaso para seguir tu racha.'),
    ('Pausa de hidratación', 'Unos tragos de agua y sigue con tu día.'),
  ];

  static String payloadFor(int snoozeMinutes) => 'snooze:$snoozeMinutes';

  static int snoozeMinutesFrom(String? payload) {
    final parts = (payload ?? '').split(':');
    return parts.length == 2 ? int.tryParse(parts[1]) ?? 15 : 15;
  }

  Future<void> init({void Function(NotificationResponse)? onForegroundResponse}) async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    final darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: [
        DarwinNotificationCategory(
          _categoryId,
          actions: [DarwinNotificationAction.plain(snoozeActionId, 'Posponer')],
        ),
      ],
    );
    await _plugin.initialize(
      settings: InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: darwin,
      ),
      onDidReceiveNotificationResponse: (r) async {
        if (r.actionId == snoozeActionId) {
          await scheduleSnooze(snoozeMinutesFrom(r.payload));
        }
        onForegroundResponse?.call(r);
      },
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
    );
    _initialized = true;
  }

  NotificationDetails _details(int snoozeMinutes) => NotificationDetails(
        android: AndroidNotificationDetails(
          'hydration_reminders',
          'Recordatorios de hidratación',
          channelDescription: 'Avisos para beber agua durante el día',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          actions: [AndroidNotificationAction(snoozeActionId, 'Posponer $snoozeMinutes min')],
        ),
        iOS: const DarwinNotificationDetails(categoryIdentifier: _categoryId),
      );

  Future<bool> hasPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _plugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final p = await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.checkPermissions();
      return p?.isEnabled ?? false;
    }
    return false;
  }

  /// Pide el permiso de notificaciones (Android 13+ e iOS).
  Future<bool> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return await _plugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ??
          false;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return await _plugin
              .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return false;
  }

  Future<void> cancelReminders() async {
    for (var i = 0; i < maxReminderSlots; i++) {
      await _plugin.cancel(id: reminderBaseId + i);
    }
  }

  /// Reemplaza todos los recordatorios programados por [times] (hora local).
  Future<void> scheduleReminders(List<DateTime> times, {required int snoozeMinutes}) async {
    await cancelReminders();
    final details = _details(snoozeMinutes);
    for (var i = 0; i < times.length && i < maxReminderSlots; i++) {
      final (title, body) = _messages[i % _messages.length];
      await _plugin.zonedSchedule(
        id: reminderBaseId + i,
        scheduledDate: tz.TZDateTime.from(times[i], tz.UTC),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: title,
        body: body,
        payload: payloadFor(snoozeMinutes),
      );
    }
  }

  Future<void> scheduleSnooze(int minutes) async {
    await _plugin.zonedSchedule(
      id: snoozeId,
      scheduledDate: tz.TZDateTime.from(DateTime.now().add(Duration(minutes: minutes)), tz.UTC),
      notificationDetails: _details(minutes),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      title: 'Hora de un sorbo',
      body: 'Te lo recordamos de nuevo, como pediste.',
      payload: payloadFor(minutes),
    );
  }

  Future<void> showTest({required int snoozeMinutes}) => _plugin.show(
        id: testId,
        title: 'Así se verán tus recordatorios',
        body: 'Aqua te avisará para beber agua.',
        notificationDetails: _details(snoozeMinutes),
        payload: payloadFor(snoozeMinutes),
      );
}
