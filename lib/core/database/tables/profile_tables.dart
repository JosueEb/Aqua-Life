import 'package:drift/drift.dart';

/// Perfil local (invitado o con nombre). No es autenticación real.
@DataClassName('UserRow')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get email => text().nullable()();
  RealColumn get weightKg => real().nullable()();
  TextColumn get unitSystem => text().withDefault(const Constant('metric'))();
  BoolColumn get isGuest => boolean().withDefault(const Constant(true))();
  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ReminderSettingsRow')
class ReminderSettings extends Table {
  TextColumn get userId => text().references(Users, #id, onDelete: KeyAction.cascade)();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();

  /// Minutos desde medianoche (hora local).
  IntColumn get startMinutes => integer()();
  IntColumn get endMinutes => integer()();
  IntColumn get intervalMinutes => integer()();

  /// Días ISO separados por coma: 1 = lunes … 7 = domingo.
  TextColumn get weekdays => text().withDefault(const Constant('1,2,3,4,5,6,7'))();
  IntColumn get snoozeMinutes => integer()();

  @override
  Set<Column> get primaryKey => {userId};
}
