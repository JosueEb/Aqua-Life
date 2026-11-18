import 'package:aqua_life/core/constants/app_constants.dart';
import 'package:aqua_life/core/database/app_database.dart';
import 'package:aqua_life/core/notifications/notification_service.dart';
import 'package:aqua_life/core/providers/core_providers.dart';
import 'package:aqua_life/core/utils/volume_format.dart';
import 'package:aqua_life/features/hydration/data/repositories/hydration_repository_impl.dart';
import 'package:aqua_life/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aqua_life/features/profile/domain/entities/user_profile.dart';
import 'package:aqua_life/features/reminders/data/reminder_repository.dart';
import 'package:aqua_life/features/reminders/domain/reminder_config.dart';
import 'package:aqua_life/features/reminders/presentation/reminder_providers.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Registra lo que se programaría en lugar de llamar al plugin nativo.
class _FakeNotifications extends NotificationService {
  List<DateTime>? scheduled;
  int cancels = 0;

  @override
  Future<void> init({void Function(NotificationResponse)? onForegroundResponse}) async {}

  @override
  Future<void> cancelReminders() async => cancels++;

  @override
  Future<void> scheduleReminders(List<DateTime> times, {required int snoozeMinutes}) async => scheduled = times;
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;
  late _FakeNotifications notifications;
  late String userId;
  final now = DateTime(2026, 11, 17, 10); // martes

  setUp(() async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    db = AppDatabase(NativeDatabase.memory());
    userId = await ProfileRepositoryImpl(db, const Uuid()).completeOnboarding(
      const OnboardingData(isGuest: true, dailyGoalMl: 1000, unitSystem: UnitSystem.metric),
      now,
    );
    SharedPreferences.setMockInitialValues({PrefKeys.currentUserId: userId, PrefKeys.onboardingCompleted: true});
    notifications = _FakeNotifications();
    container = ProviderContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(await SharedPreferences.getInstance()),
      appDatabaseProvider.overrideWithValue(db),
      clockProvider.overrideWithValue(() => now),
      notificationServiceProvider.overrideWithValue(notifications),
    ]);
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  Future<void> saveConfig({required bool enabled}) => ReminderRepositoryImpl(db).save(
        userId,
        ReminderConfig(
          enabled: enabled,
          startMinutes: 8 * 60,
          endMinutes: 20 * 60,
          intervalMinutes: 120,
          weekdays: const {1, 2, 3, 4, 5, 6, 7},
          snoozeMinutes: 15,
        ),
      );

  test('desactivados: cancela y no programa', () async {
    await saveConfig(enabled: false);
    await container.read(reminderSyncProvider).sync();
    expect(notifications.cancels, 1);
    expect(notifications.scheduled, isNull);
  });

  test('activados: programa avisos futuros desde la configuración guardada', () async {
    await saveConfig(enabled: true);
    await container.read(reminderSyncProvider).sync();
    final times = notifications.scheduled!;
    expect(times, isNotEmpty);
    expect(times.first, DateTime(2026, 11, 17, 12));
    expect(times.every((t) => t.isAfter(now)), isTrue);
  });

  test('con la meta de hoy cumplida, el siguiente aviso es mañana', () async {
    await saveConfig(enabled: true);
    await HydrationRepositoryImpl(db, const Uuid(), () => now).addIntake(userId, 1000, now);
    await container.read(reminderSyncProvider).sync();
    expect(notifications.scheduled!.first, DateTime(2026, 11, 18, 8));
  });
}
