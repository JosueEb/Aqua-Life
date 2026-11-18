import 'package:aqua_life/app/aqua_life_app.dart';
import 'package:aqua_life/core/database/app_database.dart';
import 'package:aqua_life/core/providers/core_providers.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    await initializeDateFormatting('es');
  });

  testWidgets('onboarding como invitado → Inicio → registro rápido', (tester) async {
    // Aqua respeta "reducir animaciones"; así pumpAndSettle puede terminar.
    tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true));
    addTearDown(db.close);

    await tester.pumpWidget(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: const AquaLifeApp(),
    ));
    await tester.pumpAndSettle();

    // Sin onboarding completado, el router muestra el onboarding.
    expect(find.text('¡Hola! Soy Aqua'), findsOneWidget);

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();
    expect(find.text('Continuar como invitado'), findsOneWidget);

    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();
    expect(find.text('Tu meta diaria'), findsOneWidget);

    await tester.tap(find.text('Comenzar'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pumpAndSettle();

    // Inicio con barra inferior de cinco pestañas.
    expect(find.text('¡Hola, Invitado!'), findsOneWidget);
    for (final tab in ['Inicio', 'Progreso', 'Logros', 'Mascota', 'Perfil']) {
      expect(find.text(tab), findsOneWidget);
    }
    expect(prefs.getBool('onboarding_completed'), isTrue);

    await tester.tap(find.text('+250 ml'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pumpAndSettle();

    expect(find.text('250 ml'), findsWidgets);
    expect(find.textContaining('+5 XP'), findsOneWidget);

    // Desmontar antes de cerrar la base para cancelar los streams.
    await tester.pumpWidget(const SizedBox());
  });
}
