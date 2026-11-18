import 'package:aqua_life/app/aqua_life_app.dart';
import 'package:aqua_life/app/router/app_router.dart';
import 'package:aqua_life/core/constants/app_constants.dart';
import 'package:aqua_life/core/database/app_database.dart';
import 'package:aqua_life/core/providers/core_providers.dart';
import 'package:aqua_life/core/utils/volume_format.dart';
import 'package:aqua_life/features/hydration/data/repositories/hydration_repository_impl.dart';
import 'package:aqua_life/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:aqua_life/features/profile/domain/entities/user_profile.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Recorre todas las pantallas en un teléfono pequeño, vacío y con datos:
/// cualquier excepción o desbordamiento de layout hace fallar la prueba.
void main() {
  setUpAll(() async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    await initializeDateFormatting('es');
  });

  for (final withData in [false, true]) {
    testWidgets('todas las pantallas se dibujan sin errores (${withData ? 'con datos' : 'vacío'})', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
      // iPhone SE (375×667 pt), el teléfono más estrecho que se soporta.
      tester.view.physicalSize = const Size(750, 1334);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      final db = AppDatabase(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true));
      addTearDown(db.close);
      final now = DateTime.now();
      final userId = await tester.runAsync(() async {
        final id = await ProfileRepositoryImpl(db, const Uuid()).completeOnboarding(
          const OnboardingData(isGuest: true, dailyGoalMl: 2000, unitSystem: UnitSystem.metric),
          now,
        );
        if (withData) {
          final hydration = HydrationRepositoryImpl(db, const Uuid(), () => now);
          for (var d = 0; d < 7; d++) {
            await hydration.addIntake(id, 2100, now.subtract(Duration(days: d)));
          }
        }
        return id;
      });
      SharedPreferences.setMockInitialValues({
        PrefKeys.currentUserId: userId!,
        PrefKeys.onboardingCompleted: true,
      });
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appDatabaseProvider.overrideWithValue(db),
      ]);
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const AquaLifeApp()));
      await _settle(tester);

      final router = container.read(routerProvider);
      for (final route in [
        AppRoutes.home,
        AppRoutes.progress,
        AppRoutes.achievements,
        AppRoutes.pet,
        AppRoutes.profile,
        AppRoutes.history,
        AppRoutes.addIntake,
        AppRoutes.goals,
        AppRoutes.reminders,
        AppRoutes.missions,
        AppRoutes.shop,
        AppRoutes.inventory,
        AppRoutes.settings,
      ]) {
        router.go(route);
        await _settle(tester);
        expect(tester.takeException(), isNull, reason: route);
        expect(find.byType(Scaffold), findsWidgets, reason: route);
      }

      // Desmontar antes de cerrar la base para cancelar los streams.
      await tester.pumpWidget(const SizedBox());
    });
  }
}

Future<void> _settle(WidgetTester tester) async {
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
  await tester.pumpAndSettle();
}
