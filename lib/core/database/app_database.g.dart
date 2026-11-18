// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitSystemMeta = const VerificationMeta(
    'unitSystem',
  );
  @override
  late final GeneratedColumn<String> unitSystem = GeneratedColumn<String>(
    'unit_system',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('metric'),
  );
  static const VerificationMeta _isGuestMeta = const VerificationMeta(
    'isGuest',
  );
  @override
  late final GeneratedColumn<bool> isGuest = GeneratedColumn<bool>(
    'is_guest',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_guest" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    weightKg,
    unitSystem,
    isGuest,
    onboardingCompleted,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('unit_system')) {
      context.handle(
        _unitSystemMeta,
        unitSystem.isAcceptableOrUnknown(data['unit_system']!, _unitSystemMeta),
      );
    }
    if (data.containsKey('is_guest')) {
      context.handle(
        _isGuestMeta,
        isGuest.isAcceptableOrUnknown(data['is_guest']!, _isGuestMeta),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      unitSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_system'],
      )!,
      isGuest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_guest'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final String id;
  final String? name;
  final String? email;
  final double? weightKg;
  final String unitSystem;
  final bool isGuest;
  final bool onboardingCompleted;
  final DateTime createdAt;
  const UserRow({
    required this.id,
    this.name,
    this.email,
    this.weightKg,
    required this.unitSystem,
    required this.isGuest,
    required this.onboardingCompleted,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['unit_system'] = Variable<String>(unitSystem);
    map['is_guest'] = Variable<bool>(isGuest);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      unitSystem: Value(unitSystem),
      isGuest: Value(isGuest),
      onboardingCompleted: Value(onboardingCompleted),
      createdAt: Value(createdAt),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      unitSystem: serializer.fromJson<String>(json['unitSystem']),
      isGuest: serializer.fromJson<bool>(json['isGuest']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'email': serializer.toJson<String?>(email),
      'weightKg': serializer.toJson<double?>(weightKg),
      'unitSystem': serializer.toJson<String>(unitSystem),
      'isGuest': serializer.toJson<bool>(isGuest),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserRow copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    String? unitSystem,
    bool? isGuest,
    bool? onboardingCompleted,
    DateTime? createdAt,
  }) => UserRow(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    email: email.present ? email.value : this.email,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    unitSystem: unitSystem ?? this.unitSystem,
    isGuest: isGuest ?? this.isGuest,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    createdAt: createdAt ?? this.createdAt,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      unitSystem: data.unitSystem.present
          ? data.unitSystem.value
          : this.unitSystem,
      isGuest: data.isGuest.present ? data.isGuest.value : this.isGuest,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('weightKg: $weightKg, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('isGuest: $isGuest, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    weightKg,
    unitSystem,
    isGuest,
    onboardingCompleted,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.weightKg == this.weightKg &&
          other.unitSystem == this.unitSystem &&
          other.isGuest == this.isGuest &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> email;
  final Value<double?> weightKg;
  final Value<String> unitSystem;
  final Value<bool> isGuest;
  final Value<bool> onboardingCompleted;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.isGuest = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.isGuest = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt);
  static Insertable<UserRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<double>? weightKg,
    Expression<String>? unitSystem,
    Expression<bool>? isGuest,
    Expression<bool>? onboardingCompleted,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (weightKg != null) 'weight_kg': weightKg,
      if (unitSystem != null) 'unit_system': unitSystem,
      if (isGuest != null) 'is_guest': isGuest,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? email,
    Value<double?>? weightKg,
    Value<String>? unitSystem,
    Value<bool>? isGuest,
    Value<bool>? onboardingCompleted,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      weightKg: weightKg ?? this.weightKg,
      unitSystem: unitSystem ?? this.unitSystem,
      isGuest: isGuest ?? this.isGuest,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (unitSystem.present) {
      map['unit_system'] = Variable<String>(unitSystem.value);
    }
    if (isGuest.present) {
      map['is_guest'] = Variable<bool>(isGuest.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('weightKg: $weightKg, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('isGuest: $isGuest, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderSettingsTable extends ReminderSettings
    with TableInfo<$ReminderSettingsTable, ReminderSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startMinutesMeta = const VerificationMeta(
    'startMinutes',
  );
  @override
  late final GeneratedColumn<int> startMinutes = GeneratedColumn<int>(
    'start_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinutesMeta = const VerificationMeta(
    'endMinutes',
  );
  @override
  late final GeneratedColumn<int> endMinutes = GeneratedColumn<int>(
    'end_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMinutesMeta = const VerificationMeta(
    'intervalMinutes',
  );
  @override
  late final GeneratedColumn<int> intervalMinutes = GeneratedColumn<int>(
    'interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
    'weekdays',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1,2,3,4,5,6,7'),
  );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    enabled,
    startMinutes,
    endMinutes,
    intervalMinutes,
    weekdays,
    snoozeMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('start_minutes')) {
      context.handle(
        _startMinutesMeta,
        startMinutes.isAcceptableOrUnknown(
          data['start_minutes']!,
          _startMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinutesMeta);
    }
    if (data.containsKey('end_minutes')) {
      context.handle(
        _endMinutesMeta,
        endMinutes.isAcceptableOrUnknown(data['end_minutes']!, _endMinutesMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinutesMeta);
    }
    if (data.containsKey('interval_minutes')) {
      context.handle(
        _intervalMinutesMeta,
        intervalMinutes.isAcceptableOrUnknown(
          data['interval_minutes']!,
          _intervalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalMinutesMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snoozeMinutesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  ReminderSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderSettingsRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      startMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minutes'],
      )!,
      endMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minutes'],
      )!,
      intervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_minutes'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      )!,
    );
  }

  @override
  $ReminderSettingsTable createAlias(String alias) {
    return $ReminderSettingsTable(attachedDatabase, alias);
  }
}

class ReminderSettingsRow extends DataClass
    implements Insertable<ReminderSettingsRow> {
  final String userId;
  final bool enabled;

  /// Minutos desde medianoche (hora local).
  final int startMinutes;
  final int endMinutes;
  final int intervalMinutes;

  /// Días ISO separados por coma: 1 = lunes … 7 = domingo.
  final String weekdays;
  final int snoozeMinutes;
  const ReminderSettingsRow({
    required this.userId,
    required this.enabled,
    required this.startMinutes,
    required this.endMinutes,
    required this.intervalMinutes,
    required this.weekdays,
    required this.snoozeMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['enabled'] = Variable<bool>(enabled);
    map['start_minutes'] = Variable<int>(startMinutes);
    map['end_minutes'] = Variable<int>(endMinutes);
    map['interval_minutes'] = Variable<int>(intervalMinutes);
    map['weekdays'] = Variable<String>(weekdays);
    map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    return map;
  }

  ReminderSettingsCompanion toCompanion(bool nullToAbsent) {
    return ReminderSettingsCompanion(
      userId: Value(userId),
      enabled: Value(enabled),
      startMinutes: Value(startMinutes),
      endMinutes: Value(endMinutes),
      intervalMinutes: Value(intervalMinutes),
      weekdays: Value(weekdays),
      snoozeMinutes: Value(snoozeMinutes),
    );
  }

  factory ReminderSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderSettingsRow(
      userId: serializer.fromJson<String>(json['userId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      startMinutes: serializer.fromJson<int>(json['startMinutes']),
      endMinutes: serializer.fromJson<int>(json['endMinutes']),
      intervalMinutes: serializer.fromJson<int>(json['intervalMinutes']),
      weekdays: serializer.fromJson<String>(json['weekdays']),
      snoozeMinutes: serializer.fromJson<int>(json['snoozeMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'enabled': serializer.toJson<bool>(enabled),
      'startMinutes': serializer.toJson<int>(startMinutes),
      'endMinutes': serializer.toJson<int>(endMinutes),
      'intervalMinutes': serializer.toJson<int>(intervalMinutes),
      'weekdays': serializer.toJson<String>(weekdays),
      'snoozeMinutes': serializer.toJson<int>(snoozeMinutes),
    };
  }

  ReminderSettingsRow copyWith({
    String? userId,
    bool? enabled,
    int? startMinutes,
    int? endMinutes,
    int? intervalMinutes,
    String? weekdays,
    int? snoozeMinutes,
  }) => ReminderSettingsRow(
    userId: userId ?? this.userId,
    enabled: enabled ?? this.enabled,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    weekdays: weekdays ?? this.weekdays,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
  );
  ReminderSettingsRow copyWithCompanion(ReminderSettingsCompanion data) {
    return ReminderSettingsRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      startMinutes: data.startMinutes.present
          ? data.startMinutes.value
          : this.startMinutes,
      endMinutes: data.endMinutes.present
          ? data.endMinutes.value
          : this.endMinutes,
      intervalMinutes: data.intervalMinutes.present
          ? data.intervalMinutes.value
          : this.intervalMinutes,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSettingsRow(')
          ..write('userId: $userId, ')
          ..write('enabled: $enabled, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('weekdays: $weekdays, ')
          ..write('snoozeMinutes: $snoozeMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    enabled,
    startMinutes,
    endMinutes,
    intervalMinutes,
    weekdays,
    snoozeMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderSettingsRow &&
          other.userId == this.userId &&
          other.enabled == this.enabled &&
          other.startMinutes == this.startMinutes &&
          other.endMinutes == this.endMinutes &&
          other.intervalMinutes == this.intervalMinutes &&
          other.weekdays == this.weekdays &&
          other.snoozeMinutes == this.snoozeMinutes);
}

class ReminderSettingsCompanion extends UpdateCompanion<ReminderSettingsRow> {
  final Value<String> userId;
  final Value<bool> enabled;
  final Value<int> startMinutes;
  final Value<int> endMinutes;
  final Value<int> intervalMinutes;
  final Value<String> weekdays;
  final Value<int> snoozeMinutes;
  final Value<int> rowid;
  const ReminderSettingsCompanion({
    this.userId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderSettingsCompanion.insert({
    required String userId,
    this.enabled = const Value.absent(),
    required int startMinutes,
    required int endMinutes,
    required int intervalMinutes,
    this.weekdays = const Value.absent(),
    required int snoozeMinutes,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       startMinutes = Value(startMinutes),
       endMinutes = Value(endMinutes),
       intervalMinutes = Value(intervalMinutes),
       snoozeMinutes = Value(snoozeMinutes);
  static Insertable<ReminderSettingsRow> custom({
    Expression<String>? userId,
    Expression<bool>? enabled,
    Expression<int>? startMinutes,
    Expression<int>? endMinutes,
    Expression<int>? intervalMinutes,
    Expression<String>? weekdays,
    Expression<int>? snoozeMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (enabled != null) 'enabled': enabled,
      if (startMinutes != null) 'start_minutes': startMinutes,
      if (endMinutes != null) 'end_minutes': endMinutes,
      if (intervalMinutes != null) 'interval_minutes': intervalMinutes,
      if (weekdays != null) 'weekdays': weekdays,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderSettingsCompanion copyWith({
    Value<String>? userId,
    Value<bool>? enabled,
    Value<int>? startMinutes,
    Value<int>? endMinutes,
    Value<int>? intervalMinutes,
    Value<String>? weekdays,
    Value<int>? snoozeMinutes,
    Value<int>? rowid,
  }) {
    return ReminderSettingsCompanion(
      userId: userId ?? this.userId,
      enabled: enabled ?? this.enabled,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      weekdays: weekdays ?? this.weekdays,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (startMinutes.present) {
      map['start_minutes'] = Variable<int>(startMinutes.value);
    }
    if (endMinutes.present) {
      map['end_minutes'] = Variable<int>(endMinutes.value);
    }
    if (intervalMinutes.present) {
      map['interval_minutes'] = Variable<int>(intervalMinutes.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSettingsCompanion(')
          ..write('userId: $userId, ')
          ..write('enabled: $enabled, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('weekdays: $weekdays, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HydrationGoalsTable extends HydrationGoals
    with TableInfo<$HydrationGoalsTable, HydrationGoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HydrationGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dailyGoalMlMeta = const VerificationMeta(
    'dailyGoalMl',
  );
  @override
  late final GeneratedColumn<int> dailyGoalMl = GeneratedColumn<int>(
    'daily_goal_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    dailyGoalMl,
    startDate,
    endDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hydration_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<HydrationGoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('daily_goal_ml')) {
      context.handle(
        _dailyGoalMlMeta,
        dailyGoalMl.isAcceptableOrUnknown(
          data['daily_goal_ml']!,
          _dailyGoalMlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyGoalMlMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HydrationGoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HydrationGoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      dailyGoalMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_goal_ml'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      ),
    );
  }

  @override
  $HydrationGoalsTable createAlias(String alias) {
    return $HydrationGoalsTable(attachedDatabase, alias);
  }
}

class HydrationGoalRow extends DataClass
    implements Insertable<HydrationGoalRow> {
  final int id;
  final String userId;
  final int dailyGoalMl;
  final String startDate;
  final String? endDate;
  const HydrationGoalRow({
    required this.id,
    required this.userId,
    required this.dailyGoalMl,
    required this.startDate,
    this.endDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['daily_goal_ml'] = Variable<int>(dailyGoalMl);
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    return map;
  }

  HydrationGoalsCompanion toCompanion(bool nullToAbsent) {
    return HydrationGoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      dailyGoalMl: Value(dailyGoalMl),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory HydrationGoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HydrationGoalRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      dailyGoalMl: serializer.fromJson<int>(json['dailyGoalMl']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'dailyGoalMl': serializer.toJson<int>(dailyGoalMl),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
    };
  }

  HydrationGoalRow copyWith({
    int? id,
    String? userId,
    int? dailyGoalMl,
    String? startDate,
    Value<String?> endDate = const Value.absent(),
  }) => HydrationGoalRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    dailyGoalMl: dailyGoalMl ?? this.dailyGoalMl,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
  );
  HydrationGoalRow copyWithCompanion(HydrationGoalsCompanion data) {
    return HydrationGoalRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      dailyGoalMl: data.dailyGoalMl.present
          ? data.dailyGoalMl.value
          : this.dailyGoalMl,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HydrationGoalRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dailyGoalMl: $dailyGoalMl, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, dailyGoalMl, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HydrationGoalRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.dailyGoalMl == this.dailyGoalMl &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class HydrationGoalsCompanion extends UpdateCompanion<HydrationGoalRow> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> dailyGoalMl;
  final Value<String> startDate;
  final Value<String?> endDate;
  const HydrationGoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.dailyGoalMl = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  HydrationGoalsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int dailyGoalMl,
    required String startDate,
    this.endDate = const Value.absent(),
  }) : userId = Value(userId),
       dailyGoalMl = Value(dailyGoalMl),
       startDate = Value(startDate);
  static Insertable<HydrationGoalRow> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? dailyGoalMl,
    Expression<String>? startDate,
    Expression<String>? endDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (dailyGoalMl != null) 'daily_goal_ml': dailyGoalMl,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    });
  }

  HydrationGoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? dailyGoalMl,
    Value<String>? startDate,
    Value<String?>? endDate,
  }) {
    return HydrationGoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dailyGoalMl: dailyGoalMl ?? this.dailyGoalMl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (dailyGoalMl.present) {
      map['daily_goal_ml'] = Variable<int>(dailyGoalMl.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HydrationGoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dailyGoalMl: $dailyGoalMl, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }
}

class $WaterIntakesTable extends WaterIntakes
    with TableInfo<$WaterIntakesTable, WaterIntakeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterIntakesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMlMeta = const VerificationMeta(
    'amountMl',
  );
  @override
  late final GeneratedColumn<int> amountMl = GeneratedColumn<int>(
    'amount_ml',
    aliasedName,
    false,
    check: () => ComparableExpr(amountMl).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consumedAtMeta = const VerificationMeta(
    'consumedAt',
  );
  @override
  late final GeneratedColumn<DateTime> consumedAt = GeneratedColumn<DateTime>(
    'consumed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    amountMl,
    consumedAt,
    localDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_intakes';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterIntakeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount_ml')) {
      context.handle(
        _amountMlMeta,
        amountMl.isAcceptableOrUnknown(data['amount_ml']!, _amountMlMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMlMeta);
    }
    if (data.containsKey('consumed_at')) {
      context.handle(
        _consumedAtMeta,
        consumedAt.isAcceptableOrUnknown(data['consumed_at']!, _consumedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_consumedAtMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterIntakeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterIntakeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      amountMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_ml'],
      )!,
      consumedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}consumed_at'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WaterIntakesTable createAlias(String alias) {
    return $WaterIntakesTable(attachedDatabase, alias);
  }
}

class WaterIntakeRow extends DataClass implements Insertable<WaterIntakeRow> {
  final String id;
  final String userId;
  final int amountMl;

  /// Instante del consumo (UTC).
  final DateTime consumedAt;

  /// Fecha local de agrupación (ver `LocalDate`).
  final String localDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WaterIntakeRow({
    required this.id,
    required this.userId,
    required this.amountMl,
    required this.consumedAt,
    required this.localDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['amount_ml'] = Variable<int>(amountMl);
    map['consumed_at'] = Variable<DateTime>(consumedAt);
    map['local_date'] = Variable<String>(localDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WaterIntakesCompanion toCompanion(bool nullToAbsent) {
    return WaterIntakesCompanion(
      id: Value(id),
      userId: Value(userId),
      amountMl: Value(amountMl),
      consumedAt: Value(consumedAt),
      localDate: Value(localDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WaterIntakeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterIntakeRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      amountMl: serializer.fromJson<int>(json['amountMl']),
      consumedAt: serializer.fromJson<DateTime>(json['consumedAt']),
      localDate: serializer.fromJson<String>(json['localDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'amountMl': serializer.toJson<int>(amountMl),
      'consumedAt': serializer.toJson<DateTime>(consumedAt),
      'localDate': serializer.toJson<String>(localDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WaterIntakeRow copyWith({
    String? id,
    String? userId,
    int? amountMl,
    DateTime? consumedAt,
    String? localDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WaterIntakeRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    amountMl: amountMl ?? this.amountMl,
    consumedAt: consumedAt ?? this.consumedAt,
    localDate: localDate ?? this.localDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WaterIntakeRow copyWithCompanion(WaterIntakesCompanion data) {
    return WaterIntakeRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      amountMl: data.amountMl.present ? data.amountMl.value : this.amountMl,
      consumedAt: data.consumedAt.present
          ? data.consumedAt.value
          : this.consumedAt,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterIntakeRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amountMl: $amountMl, ')
          ..write('consumedAt: $consumedAt, ')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    amountMl,
    consumedAt,
    localDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterIntakeRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.amountMl == this.amountMl &&
          other.consumedAt == this.consumedAt &&
          other.localDate == this.localDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WaterIntakesCompanion extends UpdateCompanion<WaterIntakeRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> amountMl;
  final Value<DateTime> consumedAt;
  final Value<String> localDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WaterIntakesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.amountMl = const Value.absent(),
    this.consumedAt = const Value.absent(),
    this.localDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaterIntakesCompanion.insert({
    required String id,
    required String userId,
    required int amountMl,
    required DateTime consumedAt,
    required String localDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       amountMl = Value(amountMl),
       consumedAt = Value(consumedAt),
       localDate = Value(localDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WaterIntakeRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? amountMl,
    Expression<DateTime>? consumedAt,
    Expression<String>? localDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (amountMl != null) 'amount_ml': amountMl,
      if (consumedAt != null) 'consumed_at': consumedAt,
      if (localDate != null) 'local_date': localDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaterIntakesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<int>? amountMl,
    Value<DateTime>? consumedAt,
    Value<String>? localDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WaterIntakesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amountMl: amountMl ?? this.amountMl,
      consumedAt: consumedAt ?? this.consumedAt,
      localDate: localDate ?? this.localDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amountMl.present) {
      map['amount_ml'] = Variable<int>(amountMl.value);
    }
    if (consumedAt.present) {
      map['consumed_at'] = Variable<DateTime>(consumedAt.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterIntakesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amountMl: $amountMl, ')
          ..write('consumedAt: $consumedAt, ')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyProgressTable extends DailyProgress
    with TableInfo<$DailyProgressTable, DailyProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMlMeta = const VerificationMeta(
    'totalMl',
  );
  @override
  late final GeneratedColumn<int> totalMl = GeneratedColumn<int>(
    'total_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMlMeta = const VerificationMeta('goalMl');
  @override
  late final GeneratedColumn<int> goalMl = GeneratedColumn<int>(
    'goal_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _completionPercentageMeta =
      const VerificationMeta('completionPercentage');
  @override
  late final GeneratedColumn<double> completionPercentage =
      GeneratedColumn<double>(
        'completion_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    date,
    totalMl,
    goalMl,
    completed,
    completionPercentage,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_ml')) {
      context.handle(
        _totalMlMeta,
        totalMl.isAcceptableOrUnknown(data['total_ml']!, _totalMlMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMlMeta);
    }
    if (data.containsKey('goal_ml')) {
      context.handle(
        _goalMlMeta,
        goalMl.isAcceptableOrUnknown(data['goal_ml']!, _goalMlMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMlMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('completion_percentage')) {
      context.handle(
        _completionPercentageMeta,
        completionPercentage.isAcceptableOrUnknown(
          data['completion_percentage']!,
          _completionPercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completionPercentageMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, date};
  @override
  DailyProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyProgressRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      totalMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ml'],
      )!,
      goalMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_ml'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      completionPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}completion_percentage'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyProgressTable createAlias(String alias) {
    return $DailyProgressTable(attachedDatabase, alias);
  }
}

class DailyProgressRow extends DataClass
    implements Insertable<DailyProgressRow> {
  final String userId;
  final String date;
  final int totalMl;
  final int goalMl;
  final bool completed;
  final double completionPercentage;
  final DateTime updatedAt;
  const DailyProgressRow({
    required this.userId,
    required this.date,
    required this.totalMl,
    required this.goalMl,
    required this.completed,
    required this.completionPercentage,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<String>(date);
    map['total_ml'] = Variable<int>(totalMl);
    map['goal_ml'] = Variable<int>(goalMl);
    map['completed'] = Variable<bool>(completed);
    map['completion_percentage'] = Variable<double>(completionPercentage);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyProgressCompanion toCompanion(bool nullToAbsent) {
    return DailyProgressCompanion(
      userId: Value(userId),
      date: Value(date),
      totalMl: Value(totalMl),
      goalMl: Value(goalMl),
      completed: Value(completed),
      completionPercentage: Value(completionPercentage),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyProgressRow(
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<String>(json['date']),
      totalMl: serializer.fromJson<int>(json['totalMl']),
      goalMl: serializer.fromJson<int>(json['goalMl']),
      completed: serializer.fromJson<bool>(json['completed']),
      completionPercentage: serializer.fromJson<double>(
        json['completionPercentage'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<String>(date),
      'totalMl': serializer.toJson<int>(totalMl),
      'goalMl': serializer.toJson<int>(goalMl),
      'completed': serializer.toJson<bool>(completed),
      'completionPercentage': serializer.toJson<double>(completionPercentage),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyProgressRow copyWith({
    String? userId,
    String? date,
    int? totalMl,
    int? goalMl,
    bool? completed,
    double? completionPercentage,
    DateTime? updatedAt,
  }) => DailyProgressRow(
    userId: userId ?? this.userId,
    date: date ?? this.date,
    totalMl: totalMl ?? this.totalMl,
    goalMl: goalMl ?? this.goalMl,
    completed: completed ?? this.completed,
    completionPercentage: completionPercentage ?? this.completionPercentage,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyProgressRow copyWithCompanion(DailyProgressCompanion data) {
    return DailyProgressRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      totalMl: data.totalMl.present ? data.totalMl.value : this.totalMl,
      goalMl: data.goalMl.present ? data.goalMl.value : this.goalMl,
      completed: data.completed.present ? data.completed.value : this.completed,
      completionPercentage: data.completionPercentage.present
          ? data.completionPercentage.value
          : this.completionPercentage,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressRow(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('totalMl: $totalMl, ')
          ..write('goalMl: $goalMl, ')
          ..write('completed: $completed, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    date,
    totalMl,
    goalMl,
    completed,
    completionPercentage,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyProgressRow &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.totalMl == this.totalMl &&
          other.goalMl == this.goalMl &&
          other.completed == this.completed &&
          other.completionPercentage == this.completionPercentage &&
          other.updatedAt == this.updatedAt);
}

class DailyProgressCompanion extends UpdateCompanion<DailyProgressRow> {
  final Value<String> userId;
  final Value<String> date;
  final Value<int> totalMl;
  final Value<int> goalMl;
  final Value<bool> completed;
  final Value<double> completionPercentage;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyProgressCompanion({
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.totalMl = const Value.absent(),
    this.goalMl = const Value.absent(),
    this.completed = const Value.absent(),
    this.completionPercentage = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyProgressCompanion.insert({
    required String userId,
    required String date,
    required int totalMl,
    required int goalMl,
    required bool completed,
    required double completionPercentage,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       date = Value(date),
       totalMl = Value(totalMl),
       goalMl = Value(goalMl),
       completed = Value(completed),
       completionPercentage = Value(completionPercentage),
       updatedAt = Value(updatedAt);
  static Insertable<DailyProgressRow> custom({
    Expression<String>? userId,
    Expression<String>? date,
    Expression<int>? totalMl,
    Expression<int>? goalMl,
    Expression<bool>? completed,
    Expression<double>? completionPercentage,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (totalMl != null) 'total_ml': totalMl,
      if (goalMl != null) 'goal_ml': goalMl,
      if (completed != null) 'completed': completed,
      if (completionPercentage != null)
        'completion_percentage': completionPercentage,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyProgressCompanion copyWith({
    Value<String>? userId,
    Value<String>? date,
    Value<int>? totalMl,
    Value<int>? goalMl,
    Value<bool>? completed,
    Value<double>? completionPercentage,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyProgressCompanion(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      totalMl: totalMl ?? this.totalMl,
      goalMl: goalMl ?? this.goalMl,
      completed: completed ?? this.completed,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (totalMl.present) {
      map['total_ml'] = Variable<int>(totalMl.value);
    }
    if (goalMl.present) {
      map['goal_ml'] = Variable<int>(goalMl.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completionPercentage.present) {
      map['completion_percentage'] = Variable<double>(
        completionPercentage.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressCompanion(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('totalMl: $totalMl, ')
          ..write('goalMl: $goalMl, ')
          ..write('completed: $completed, ')
          ..write('completionPercentage: $completionPercentage, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GamificationProfilesTable extends GamificationProfiles
    with TableInfo<$GamificationProfilesTable, GamificationProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GamificationProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    totalXp,
    level,
    coins,
    currentStreak,
    longestStreak,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gamification_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<GamificationProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  GamificationProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GamificationProfileRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
    );
  }

  @override
  $GamificationProfilesTable createAlias(String alias) {
    return $GamificationProfilesTable(attachedDatabase, alias);
  }
}

class GamificationProfileRow extends DataClass
    implements Insertable<GamificationProfileRow> {
  final String userId;
  final int totalXp;
  final int level;
  final int coins;
  final int currentStreak;
  final int longestStreak;
  const GamificationProfileRow({
    required this.userId,
    required this.totalXp,
    required this.level,
    required this.coins,
    required this.currentStreak,
    required this.longestStreak,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['total_xp'] = Variable<int>(totalXp);
    map['level'] = Variable<int>(level);
    map['coins'] = Variable<int>(coins);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    return map;
  }

  GamificationProfilesCompanion toCompanion(bool nullToAbsent) {
    return GamificationProfilesCompanion(
      userId: Value(userId),
      totalXp: Value(totalXp),
      level: Value(level),
      coins: Value(coins),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
    );
  }

  factory GamificationProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GamificationProfileRow(
      userId: serializer.fromJson<String>(json['userId']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      level: serializer.fromJson<int>(json['level']),
      coins: serializer.fromJson<int>(json['coins']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'totalXp': serializer.toJson<int>(totalXp),
      'level': serializer.toJson<int>(level),
      'coins': serializer.toJson<int>(coins),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
    };
  }

  GamificationProfileRow copyWith({
    String? userId,
    int? totalXp,
    int? level,
    int? coins,
    int? currentStreak,
    int? longestStreak,
  }) => GamificationProfileRow(
    userId: userId ?? this.userId,
    totalXp: totalXp ?? this.totalXp,
    level: level ?? this.level,
    coins: coins ?? this.coins,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
  );
  GamificationProfileRow copyWithCompanion(GamificationProfilesCompanion data) {
    return GamificationProfileRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      level: data.level.present ? data.level.value : this.level,
      coins: data.coins.present ? data.coins.value : this.coins,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GamificationProfileRow(')
          ..write('userId: $userId, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('coins: $coins, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, totalXp, level, coins, currentStreak, longestStreak);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GamificationProfileRow &&
          other.userId == this.userId &&
          other.totalXp == this.totalXp &&
          other.level == this.level &&
          other.coins == this.coins &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak);
}

class GamificationProfilesCompanion
    extends UpdateCompanion<GamificationProfileRow> {
  final Value<String> userId;
  final Value<int> totalXp;
  final Value<int> level;
  final Value<int> coins;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> rowid;
  const GamificationProfilesCompanion({
    this.userId = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.coins = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GamificationProfilesCompanion.insert({
    required String userId,
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.coins = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<GamificationProfileRow> custom({
    Expression<String>? userId,
    Expression<int>? totalXp,
    Expression<int>? level,
    Expression<int>? coins,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (totalXp != null) 'total_xp': totalXp,
      if (level != null) 'level': level,
      if (coins != null) 'coins': coins,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GamificationProfilesCompanion copyWith({
    Value<String>? userId,
    Value<int>? totalXp,
    Value<int>? level,
    Value<int>? coins,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<int>? rowid,
  }) {
    return GamificationProfilesCompanion(
      userId: userId ?? this.userId,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      coins: coins ?? this.coins,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GamificationProfilesCompanion(')
          ..write('userId: $userId, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('coins: $coins, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardTransactionsTable extends RewardTransactions
    with TableInfo<$RewardTransactionsTable, RewardTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    type,
    amount,
    source,
    referenceId,
    localDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceIdMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId, type, source, referenceId},
  ];
  @override
  RewardTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RewardTransactionsTable createAlias(String alias) {
    return $RewardTransactionsTable(attachedDatabase, alias);
  }
}

class RewardTransactionRow extends DataClass
    implements Insertable<RewardTransactionRow> {
  final int id;
  final String userId;
  final String type;
  final int amount;
  final String source;
  final String referenceId;
  final String localDate;
  final DateTime createdAt;
  const RewardTransactionRow({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.source,
    required this.referenceId,
    required this.localDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<int>(amount);
    map['source'] = Variable<String>(source);
    map['reference_id'] = Variable<String>(referenceId);
    map['local_date'] = Variable<String>(localDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RewardTransactionsCompanion toCompanion(bool nullToAbsent) {
    return RewardTransactionsCompanion(
      id: Value(id),
      userId: Value(userId),
      type: Value(type),
      amount: Value(amount),
      source: Value(source),
      referenceId: Value(referenceId),
      localDate: Value(localDate),
      createdAt: Value(createdAt),
    );
  }

  factory RewardTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardTransactionRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<int>(json['amount']),
      source: serializer.fromJson<String>(json['source']),
      referenceId: serializer.fromJson<String>(json['referenceId']),
      localDate: serializer.fromJson<String>(json['localDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<int>(amount),
      'source': serializer.toJson<String>(source),
      'referenceId': serializer.toJson<String>(referenceId),
      'localDate': serializer.toJson<String>(localDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RewardTransactionRow copyWith({
    int? id,
    String? userId,
    String? type,
    int? amount,
    String? source,
    String? referenceId,
    String? localDate,
    DateTime? createdAt,
  }) => RewardTransactionRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    source: source ?? this.source,
    referenceId: referenceId ?? this.referenceId,
    localDate: localDate ?? this.localDate,
    createdAt: createdAt ?? this.createdAt,
  );
  RewardTransactionRow copyWithCompanion(RewardTransactionsCompanion data) {
    return RewardTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      source: data.source.present ? data.source.value : this.source,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardTransactionRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    type,
    amount,
    source,
    referenceId,
    localDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardTransactionRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.source == this.source &&
          other.referenceId == this.referenceId &&
          other.localDate == this.localDate &&
          other.createdAt == this.createdAt);
}

class RewardTransactionsCompanion
    extends UpdateCompanion<RewardTransactionRow> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> type;
  final Value<int> amount;
  final Value<String> source;
  final Value<String> referenceId;
  final Value<String> localDate;
  final Value<DateTime> createdAt;
  const RewardTransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.source = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.localDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RewardTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String type,
    required int amount,
    required String source,
    required String referenceId,
    required String localDate,
    required DateTime createdAt,
  }) : userId = Value(userId),
       type = Value(type),
       amount = Value(amount),
       source = Value(source),
       referenceId = Value(referenceId),
       localDate = Value(localDate),
       createdAt = Value(createdAt);
  static Insertable<RewardTransactionRow> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<int>? amount,
    Expression<String>? source,
    Expression<String>? referenceId,
    Expression<String>? localDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (source != null) 'source': source,
      if (referenceId != null) 'reference_id': referenceId,
      if (localDate != null) 'local_date': localDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RewardTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? type,
    Value<int>? amount,
    Value<String>? source,
    Value<String>? referenceId,
    Value<String>? localDate,
    Value<DateTime>? createdAt,
  }) {
    return RewardTransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      referenceId: referenceId ?? this.referenceId,
      localDate: localDate ?? this.localDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('localDate: $localDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, AchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconPathMeta = const VerificationMeta(
    'iconPath',
  );
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
    'icon_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionTypeMeta = const VerificationMeta(
    'conditionType',
  );
  @override
  late final GeneratedColumn<String> conditionType = GeneratedColumn<String>(
    'condition_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionValueMeta = const VerificationMeta(
    'conditionValue',
  );
  @override
  late final GeneratedColumn<int> conditionValue = GeneratedColumn<int>(
    'condition_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _coinRewardMeta = const VerificationMeta(
    'coinReward',
  );
  @override
  late final GeneratedColumn<int> coinReward = GeneratedColumn<int>(
    'coin_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    iconPath,
    conditionType,
    conditionValue,
    xpReward,
    coinReward,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(
        _iconPathMeta,
        iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta),
      );
    } else if (isInserting) {
      context.missing(_iconPathMeta);
    }
    if (data.containsKey('condition_type')) {
      context.handle(
        _conditionTypeMeta,
        conditionType.isAcceptableOrUnknown(
          data['condition_type']!,
          _conditionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conditionTypeMeta);
    }
    if (data.containsKey('condition_value')) {
      context.handle(
        _conditionValueMeta,
        conditionValue.isAcceptableOrUnknown(
          data['condition_value']!,
          _conditionValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conditionValueMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    }
    if (data.containsKey('coin_reward')) {
      context.handle(
        _coinRewardMeta,
        coinReward.isAcceptableOrUnknown(data['coin_reward']!, _coinRewardMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      iconPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_path'],
      )!,
      conditionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition_type'],
      )!,
      conditionValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}condition_value'],
      )!,
      xpReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_reward'],
      )!,
      coinReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coin_reward'],
      )!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class AchievementRow extends DataClass implements Insertable<AchievementRow> {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final String conditionType;
  final int conditionValue;
  final int xpReward;
  final int coinReward;
  const AchievementRow({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.conditionType,
    required this.conditionValue,
    required this.xpReward,
    required this.coinReward,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['icon_path'] = Variable<String>(iconPath);
    map['condition_type'] = Variable<String>(conditionType);
    map['condition_value'] = Variable<int>(conditionValue);
    map['xp_reward'] = Variable<int>(xpReward);
    map['coin_reward'] = Variable<int>(coinReward);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      iconPath: Value(iconPath),
      conditionType: Value(conditionType),
      conditionValue: Value(conditionValue),
      xpReward: Value(xpReward),
      coinReward: Value(coinReward),
    );
  }

  factory AchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
      conditionType: serializer.fromJson<String>(json['conditionType']),
      conditionValue: serializer.fromJson<int>(json['conditionValue']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      coinReward: serializer.fromJson<int>(json['coinReward']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'iconPath': serializer.toJson<String>(iconPath),
      'conditionType': serializer.toJson<String>(conditionType),
      'conditionValue': serializer.toJson<int>(conditionValue),
      'xpReward': serializer.toJson<int>(xpReward),
      'coinReward': serializer.toJson<int>(coinReward),
    };
  }

  AchievementRow copyWith({
    String? id,
    String? title,
    String? description,
    String? iconPath,
    String? conditionType,
    int? conditionValue,
    int? xpReward,
    int? coinReward,
  }) => AchievementRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    iconPath: iconPath ?? this.iconPath,
    conditionType: conditionType ?? this.conditionType,
    conditionValue: conditionValue ?? this.conditionValue,
    xpReward: xpReward ?? this.xpReward,
    coinReward: coinReward ?? this.coinReward,
  );
  AchievementRow copyWithCompanion(AchievementsCompanion data) {
    return AchievementRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
      conditionType: data.conditionType.present
          ? data.conditionType.value
          : this.conditionType,
      conditionValue: data.conditionValue.present
          ? data.conditionValue.value
          : this.conditionValue,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      coinReward: data.coinReward.present
          ? data.coinReward.value
          : this.coinReward,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconPath: $iconPath, ')
          ..write('conditionType: $conditionType, ')
          ..write('conditionValue: $conditionValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('coinReward: $coinReward')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    iconPath,
    conditionType,
    conditionValue,
    xpReward,
    coinReward,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.iconPath == this.iconPath &&
          other.conditionType == this.conditionType &&
          other.conditionValue == this.conditionValue &&
          other.xpReward == this.xpReward &&
          other.coinReward == this.coinReward);
}

class AchievementsCompanion extends UpdateCompanion<AchievementRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> iconPath;
  final Value<String> conditionType;
  final Value<int> conditionValue;
  final Value<int> xpReward;
  final Value<int> coinReward;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.conditionType = const Value.absent(),
    this.conditionValue = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.coinReward = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required String conditionType,
    required int conditionValue,
    this.xpReward = const Value.absent(),
    this.coinReward = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       iconPath = Value(iconPath),
       conditionType = Value(conditionType),
       conditionValue = Value(conditionValue);
  static Insertable<AchievementRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? iconPath,
    Expression<String>? conditionType,
    Expression<int>? conditionValue,
    Expression<int>? xpReward,
    Expression<int>? coinReward,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (iconPath != null) 'icon_path': iconPath,
      if (conditionType != null) 'condition_type': conditionType,
      if (conditionValue != null) 'condition_value': conditionValue,
      if (xpReward != null) 'xp_reward': xpReward,
      if (coinReward != null) 'coin_reward': coinReward,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? iconPath,
    Value<String>? conditionType,
    Value<int>? conditionValue,
    Value<int>? xpReward,
    Value<int>? coinReward,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      conditionType: conditionType ?? this.conditionType,
      conditionValue: conditionValue ?? this.conditionValue,
      xpReward: xpReward ?? this.xpReward,
      coinReward: coinReward ?? this.coinReward,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (conditionType.present) {
      map['condition_type'] = Variable<String>(conditionType.value);
    }
    if (conditionValue.present) {
      map['condition_value'] = Variable<int>(conditionValue.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (coinReward.present) {
      map['coin_reward'] = Variable<int>(coinReward.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconPath: $iconPath, ')
          ..write('conditionType: $conditionType, ')
          ..write('conditionValue: $conditionValue, ')
          ..write('xpReward: $xpReward, ')
          ..write('coinReward: $coinReward, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAchievementsTable extends UserAchievements
    with TableInfo<$UserAchievementsTable, UserAchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES achievements (id)',
    ),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, achievementId, unlockedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_unlockedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, achievementId};
  @override
  UserAchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAchievementRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      achievementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_id'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      )!,
    );
  }

  @override
  $UserAchievementsTable createAlias(String alias) {
    return $UserAchievementsTable(attachedDatabase, alias);
  }
}

class UserAchievementRow extends DataClass
    implements Insertable<UserAchievementRow> {
  final String userId;
  final String achievementId;
  final DateTime unlockedAt;
  const UserAchievementRow({
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['achievement_id'] = Variable<String>(achievementId);
    map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    return map;
  }

  UserAchievementsCompanion toCompanion(bool nullToAbsent) {
    return UserAchievementsCompanion(
      userId: Value(userId),
      achievementId: Value(achievementId),
      unlockedAt: Value(unlockedAt),
    );
  }

  factory UserAchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAchievementRow(
      userId: serializer.fromJson<String>(json['userId']),
      achievementId: serializer.fromJson<String>(json['achievementId']),
      unlockedAt: serializer.fromJson<DateTime>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'achievementId': serializer.toJson<String>(achievementId),
      'unlockedAt': serializer.toJson<DateTime>(unlockedAt),
    };
  }

  UserAchievementRow copyWith({
    String? userId,
    String? achievementId,
    DateTime? unlockedAt,
  }) => UserAchievementRow(
    userId: userId ?? this.userId,
    achievementId: achievementId ?? this.achievementId,
    unlockedAt: unlockedAt ?? this.unlockedAt,
  );
  UserAchievementRow copyWithCompanion(UserAchievementsCompanion data) {
    return UserAchievementRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      achievementId: data.achievementId.present
          ? data.achievementId.value
          : this.achievementId,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievementRow(')
          ..write('userId: $userId, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, achievementId, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAchievementRow &&
          other.userId == this.userId &&
          other.achievementId == this.achievementId &&
          other.unlockedAt == this.unlockedAt);
}

class UserAchievementsCompanion extends UpdateCompanion<UserAchievementRow> {
  final Value<String> userId;
  final Value<String> achievementId;
  final Value<DateTime> unlockedAt;
  final Value<int> rowid;
  const UserAchievementsCompanion({
    this.userId = const Value.absent(),
    this.achievementId = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAchievementsCompanion.insert({
    required String userId,
    required String achievementId,
    required DateTime unlockedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       achievementId = Value(achievementId),
       unlockedAt = Value(unlockedAt);
  static Insertable<UserAchievementRow> custom({
    Expression<String>? userId,
    Expression<String>? achievementId,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (achievementId != null) 'achievement_id': achievementId,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAchievementsCompanion copyWith({
    Value<String>? userId,
    Value<String>? achievementId,
    Value<DateTime>? unlockedAt,
    Value<int>? rowid,
  }) {
    return UserAchievementsCompanion(
      userId: userId ?? this.userId,
      achievementId: achievementId ?? this.achievementId,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievementsCompanion(')
          ..write('userId: $userId, ')
          ..write('achievementId: $achievementId, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MissionsTable extends Missions
    with TableInfo<$MissionsTable, MissionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    period,
    metric,
    target,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'missions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MissionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MissionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MissionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
    );
  }

  @override
  $MissionsTable createAlias(String alias) {
    return $MissionsTable(attachedDatabase, alias);
  }
}

class MissionRow extends DataClass implements Insertable<MissionRow> {
  final String id;
  final String title;
  final String description;
  final String period;
  final String metric;
  final int target;
  const MissionRow({
    required this.id,
    required this.title,
    required this.description,
    required this.period,
    required this.metric,
    required this.target,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['period'] = Variable<String>(period);
    map['metric'] = Variable<String>(metric);
    map['target'] = Variable<int>(target);
    return map;
  }

  MissionsCompanion toCompanion(bool nullToAbsent) {
    return MissionsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      period: Value(period),
      metric: Value(metric),
      target: Value(target),
    );
  }

  factory MissionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MissionRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      period: serializer.fromJson<String>(json['period']),
      metric: serializer.fromJson<String>(json['metric']),
      target: serializer.fromJson<int>(json['target']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'period': serializer.toJson<String>(period),
      'metric': serializer.toJson<String>(metric),
      'target': serializer.toJson<int>(target),
    };
  }

  MissionRow copyWith({
    String? id,
    String? title,
    String? description,
    String? period,
    String? metric,
    int? target,
  }) => MissionRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    period: period ?? this.period,
    metric: metric ?? this.metric,
    target: target ?? this.target,
  );
  MissionRow copyWithCompanion(MissionsCompanion data) {
    return MissionRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      period: data.period.present ? data.period.value : this.period,
      metric: data.metric.present ? data.metric.value : this.metric,
      target: data.target.present ? data.target.value : this.target,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MissionRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('period: $period, ')
          ..write('metric: $metric, ')
          ..write('target: $target')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, period, metric, target);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissionRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.period == this.period &&
          other.metric == this.metric &&
          other.target == this.target);
}

class MissionsCompanion extends UpdateCompanion<MissionRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> period;
  final Value<String> metric;
  final Value<int> target;
  final Value<int> rowid;
  const MissionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.period = const Value.absent(),
    this.metric = const Value.absent(),
    this.target = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MissionsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String period,
    required String metric,
    required int target,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       period = Value(period),
       metric = Value(metric),
       target = Value(target);
  static Insertable<MissionRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? period,
    Expression<String>? metric,
    Expression<int>? target,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (period != null) 'period': period,
      if (metric != null) 'metric': metric,
      if (target != null) 'target': target,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MissionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? period,
    Value<String>? metric,
    Value<int>? target,
    Value<int>? rowid,
  }) {
    return MissionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      period: period ?? this.period,
      metric: metric ?? this.metric,
      target: target ?? this.target,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MissionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('period: $period, ')
          ..write('metric: $metric, ')
          ..write('target: $target, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserMissionsTable extends UserMissions
    with TableInfo<$UserMissionsTable, UserMissionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserMissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _missionIdMeta = const VerificationMeta(
    'missionId',
  );
  @override
  late final GeneratedColumn<String> missionId = GeneratedColumn<String>(
    'mission_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES missions (id)',
    ),
  );
  static const VerificationMeta _periodStartMeta = const VerificationMeta(
    'periodStart',
  );
  @override
  late final GeneratedColumn<String> periodStart = GeneratedColumn<String>(
    'period_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _claimedMeta = const VerificationMeta(
    'claimed',
  );
  @override
  late final GeneratedColumn<bool> claimed = GeneratedColumn<bool>(
    'claimed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("claimed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    missionId,
    periodStart,
    progress,
    completed,
    claimed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_missions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserMissionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('mission_id')) {
      context.handle(
        _missionIdMeta,
        missionId.isAcceptableOrUnknown(data['mission_id']!, _missionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_missionIdMeta);
    }
    if (data.containsKey('period_start')) {
      context.handle(
        _periodStartMeta,
        periodStart.isAcceptableOrUnknown(
          data['period_start']!,
          _periodStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_periodStartMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('claimed')) {
      context.handle(
        _claimedMeta,
        claimed.isAcceptableOrUnknown(data['claimed']!, _claimedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId, missionId, periodStart},
  ];
  @override
  UserMissionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserMissionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      missionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mission_id'],
      )!,
      periodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_start'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      claimed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}claimed'],
      )!,
    );
  }

  @override
  $UserMissionsTable createAlias(String alias) {
    return $UserMissionsTable(attachedDatabase, alias);
  }
}

class UserMissionRow extends DataClass implements Insertable<UserMissionRow> {
  final int id;
  final String userId;
  final String missionId;
  final String periodStart;
  final int progress;
  final bool completed;
  final bool claimed;
  const UserMissionRow({
    required this.id,
    required this.userId,
    required this.missionId,
    required this.periodStart,
    required this.progress,
    required this.completed,
    required this.claimed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['mission_id'] = Variable<String>(missionId);
    map['period_start'] = Variable<String>(periodStart);
    map['progress'] = Variable<int>(progress);
    map['completed'] = Variable<bool>(completed);
    map['claimed'] = Variable<bool>(claimed);
    return map;
  }

  UserMissionsCompanion toCompanion(bool nullToAbsent) {
    return UserMissionsCompanion(
      id: Value(id),
      userId: Value(userId),
      missionId: Value(missionId),
      periodStart: Value(periodStart),
      progress: Value(progress),
      completed: Value(completed),
      claimed: Value(claimed),
    );
  }

  factory UserMissionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserMissionRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      missionId: serializer.fromJson<String>(json['missionId']),
      periodStart: serializer.fromJson<String>(json['periodStart']),
      progress: serializer.fromJson<int>(json['progress']),
      completed: serializer.fromJson<bool>(json['completed']),
      claimed: serializer.fromJson<bool>(json['claimed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'missionId': serializer.toJson<String>(missionId),
      'periodStart': serializer.toJson<String>(periodStart),
      'progress': serializer.toJson<int>(progress),
      'completed': serializer.toJson<bool>(completed),
      'claimed': serializer.toJson<bool>(claimed),
    };
  }

  UserMissionRow copyWith({
    int? id,
    String? userId,
    String? missionId,
    String? periodStart,
    int? progress,
    bool? completed,
    bool? claimed,
  }) => UserMissionRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    missionId: missionId ?? this.missionId,
    periodStart: periodStart ?? this.periodStart,
    progress: progress ?? this.progress,
    completed: completed ?? this.completed,
    claimed: claimed ?? this.claimed,
  );
  UserMissionRow copyWithCompanion(UserMissionsCompanion data) {
    return UserMissionRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      missionId: data.missionId.present ? data.missionId.value : this.missionId,
      periodStart: data.periodStart.present
          ? data.periodStart.value
          : this.periodStart,
      progress: data.progress.present ? data.progress.value : this.progress,
      completed: data.completed.present ? data.completed.value : this.completed,
      claimed: data.claimed.present ? data.claimed.value : this.claimed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserMissionRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('missionId: $missionId, ')
          ..write('periodStart: $periodStart, ')
          ..write('progress: $progress, ')
          ..write('completed: $completed, ')
          ..write('claimed: $claimed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    missionId,
    periodStart,
    progress,
    completed,
    claimed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserMissionRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.missionId == this.missionId &&
          other.periodStart == this.periodStart &&
          other.progress == this.progress &&
          other.completed == this.completed &&
          other.claimed == this.claimed);
}

class UserMissionsCompanion extends UpdateCompanion<UserMissionRow> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> missionId;
  final Value<String> periodStart;
  final Value<int> progress;
  final Value<bool> completed;
  final Value<bool> claimed;
  const UserMissionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.missionId = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.progress = const Value.absent(),
    this.completed = const Value.absent(),
    this.claimed = const Value.absent(),
  });
  UserMissionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String missionId,
    required String periodStart,
    this.progress = const Value.absent(),
    this.completed = const Value.absent(),
    this.claimed = const Value.absent(),
  }) : userId = Value(userId),
       missionId = Value(missionId),
       periodStart = Value(periodStart);
  static Insertable<UserMissionRow> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? missionId,
    Expression<String>? periodStart,
    Expression<int>? progress,
    Expression<bool>? completed,
    Expression<bool>? claimed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (missionId != null) 'mission_id': missionId,
      if (periodStart != null) 'period_start': periodStart,
      if (progress != null) 'progress': progress,
      if (completed != null) 'completed': completed,
      if (claimed != null) 'claimed': claimed,
    });
  }

  UserMissionsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? missionId,
    Value<String>? periodStart,
    Value<int>? progress,
    Value<bool>? completed,
    Value<bool>? claimed,
  }) {
    return UserMissionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      missionId: missionId ?? this.missionId,
      periodStart: periodStart ?? this.periodStart,
      progress: progress ?? this.progress,
      completed: completed ?? this.completed,
      claimed: claimed ?? this.claimed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (missionId.present) {
      map['mission_id'] = Variable<String>(missionId.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<String>(periodStart.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (claimed.present) {
      map['claimed'] = Variable<bool>(claimed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserMissionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('missionId: $missionId, ')
          ..write('periodStart: $periodStart, ')
          ..write('progress: $progress, ')
          ..write('completed: $completed, ')
          ..write('claimed: $claimed')
          ..write(')'))
        .toString();
  }
}

class $PetsTable extends Pets with TableInfo<$PetsTable, PetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('aqua'),
  );
  static const VerificationMeta _evolutionStageMeta = const VerificationMeta(
    'evolutionStage',
  );
  @override
  late final GeneratedColumn<int> evolutionStage = GeneratedColumn<int>(
    'evolution_stage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _happinessMeta = const VerificationMeta(
    'happiness',
  );
  @override
  late final GeneratedColumn<int> happiness = GeneratedColumn<int>(
    'happiness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('idle'),
  );
  static const VerificationMeta _equippedAccessoryMeta = const VerificationMeta(
    'equippedAccessory',
  );
  @override
  late final GeneratedColumn<String> equippedAccessory =
      GeneratedColumn<String>(
        'equipped_accessory',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    species,
    evolutionStage,
    xp,
    happiness,
    mood,
    equippedAccessory,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    }
    if (data.containsKey('evolution_stage')) {
      context.handle(
        _evolutionStageMeta,
        evolutionStage.isAcceptableOrUnknown(
          data['evolution_stage']!,
          _evolutionStageMeta,
        ),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('happiness')) {
      context.handle(
        _happinessMeta,
        happiness.isAcceptableOrUnknown(data['happiness']!, _happinessMeta),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('equipped_accessory')) {
      context.handle(
        _equippedAccessoryMeta,
        equippedAccessory.isAcceptableOrUnknown(
          data['equipped_accessory']!,
          _equippedAccessoryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  PetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      evolutionStage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}evolution_stage'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      happiness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}happiness'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      )!,
      equippedAccessory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipped_accessory'],
      ),
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class PetRow extends DataClass implements Insertable<PetRow> {
  final String userId;
  final String species;
  final int evolutionStage;
  final int xp;
  final int happiness;
  final String mood;
  final String? equippedAccessory;
  const PetRow({
    required this.userId,
    required this.species,
    required this.evolutionStage,
    required this.xp,
    required this.happiness,
    required this.mood,
    this.equippedAccessory,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['species'] = Variable<String>(species);
    map['evolution_stage'] = Variable<int>(evolutionStage);
    map['xp'] = Variable<int>(xp);
    map['happiness'] = Variable<int>(happiness);
    map['mood'] = Variable<String>(mood);
    if (!nullToAbsent || equippedAccessory != null) {
      map['equipped_accessory'] = Variable<String>(equippedAccessory);
    }
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      userId: Value(userId),
      species: Value(species),
      evolutionStage: Value(evolutionStage),
      xp: Value(xp),
      happiness: Value(happiness),
      mood: Value(mood),
      equippedAccessory: equippedAccessory == null && nullToAbsent
          ? const Value.absent()
          : Value(equippedAccessory),
    );
  }

  factory PetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetRow(
      userId: serializer.fromJson<String>(json['userId']),
      species: serializer.fromJson<String>(json['species']),
      evolutionStage: serializer.fromJson<int>(json['evolutionStage']),
      xp: serializer.fromJson<int>(json['xp']),
      happiness: serializer.fromJson<int>(json['happiness']),
      mood: serializer.fromJson<String>(json['mood']),
      equippedAccessory: serializer.fromJson<String?>(
        json['equippedAccessory'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'species': serializer.toJson<String>(species),
      'evolutionStage': serializer.toJson<int>(evolutionStage),
      'xp': serializer.toJson<int>(xp),
      'happiness': serializer.toJson<int>(happiness),
      'mood': serializer.toJson<String>(mood),
      'equippedAccessory': serializer.toJson<String?>(equippedAccessory),
    };
  }

  PetRow copyWith({
    String? userId,
    String? species,
    int? evolutionStage,
    int? xp,
    int? happiness,
    String? mood,
    Value<String?> equippedAccessory = const Value.absent(),
  }) => PetRow(
    userId: userId ?? this.userId,
    species: species ?? this.species,
    evolutionStage: evolutionStage ?? this.evolutionStage,
    xp: xp ?? this.xp,
    happiness: happiness ?? this.happiness,
    mood: mood ?? this.mood,
    equippedAccessory: equippedAccessory.present
        ? equippedAccessory.value
        : this.equippedAccessory,
  );
  PetRow copyWithCompanion(PetsCompanion data) {
    return PetRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      species: data.species.present ? data.species.value : this.species,
      evolutionStage: data.evolutionStage.present
          ? data.evolutionStage.value
          : this.evolutionStage,
      xp: data.xp.present ? data.xp.value : this.xp,
      happiness: data.happiness.present ? data.happiness.value : this.happiness,
      mood: data.mood.present ? data.mood.value : this.mood,
      equippedAccessory: data.equippedAccessory.present
          ? data.equippedAccessory.value
          : this.equippedAccessory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetRow(')
          ..write('userId: $userId, ')
          ..write('species: $species, ')
          ..write('evolutionStage: $evolutionStage, ')
          ..write('xp: $xp, ')
          ..write('happiness: $happiness, ')
          ..write('mood: $mood, ')
          ..write('equippedAccessory: $equippedAccessory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    species,
    evolutionStage,
    xp,
    happiness,
    mood,
    equippedAccessory,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetRow &&
          other.userId == this.userId &&
          other.species == this.species &&
          other.evolutionStage == this.evolutionStage &&
          other.xp == this.xp &&
          other.happiness == this.happiness &&
          other.mood == this.mood &&
          other.equippedAccessory == this.equippedAccessory);
}

class PetsCompanion extends UpdateCompanion<PetRow> {
  final Value<String> userId;
  final Value<String> species;
  final Value<int> evolutionStage;
  final Value<int> xp;
  final Value<int> happiness;
  final Value<String> mood;
  final Value<String?> equippedAccessory;
  final Value<int> rowid;
  const PetsCompanion({
    this.userId = const Value.absent(),
    this.species = const Value.absent(),
    this.evolutionStage = const Value.absent(),
    this.xp = const Value.absent(),
    this.happiness = const Value.absent(),
    this.mood = const Value.absent(),
    this.equippedAccessory = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PetsCompanion.insert({
    required String userId,
    this.species = const Value.absent(),
    this.evolutionStage = const Value.absent(),
    this.xp = const Value.absent(),
    this.happiness = const Value.absent(),
    this.mood = const Value.absent(),
    this.equippedAccessory = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<PetRow> custom({
    Expression<String>? userId,
    Expression<String>? species,
    Expression<int>? evolutionStage,
    Expression<int>? xp,
    Expression<int>? happiness,
    Expression<String>? mood,
    Expression<String>? equippedAccessory,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (species != null) 'species': species,
      if (evolutionStage != null) 'evolution_stage': evolutionStage,
      if (xp != null) 'xp': xp,
      if (happiness != null) 'happiness': happiness,
      if (mood != null) 'mood': mood,
      if (equippedAccessory != null) 'equipped_accessory': equippedAccessory,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PetsCompanion copyWith({
    Value<String>? userId,
    Value<String>? species,
    Value<int>? evolutionStage,
    Value<int>? xp,
    Value<int>? happiness,
    Value<String>? mood,
    Value<String?>? equippedAccessory,
    Value<int>? rowid,
  }) {
    return PetsCompanion(
      userId: userId ?? this.userId,
      species: species ?? this.species,
      evolutionStage: evolutionStage ?? this.evolutionStage,
      xp: xp ?? this.xp,
      happiness: happiness ?? this.happiness,
      mood: mood ?? this.mood,
      equippedAccessory: equippedAccessory ?? this.equippedAccessory,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (evolutionStage.present) {
      map['evolution_stage'] = Variable<int>(evolutionStage.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (happiness.present) {
      map['happiness'] = Variable<int>(happiness.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (equippedAccessory.present) {
      map['equipped_accessory'] = Variable<String>(equippedAccessory.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('userId: $userId, ')
          ..write('species: $species, ')
          ..write('evolutionStage: $evolutionStage, ')
          ..write('xp: $xp, ')
          ..write('happiness: $happiness, ')
          ..write('mood: $mood, ')
          ..write('equippedAccessory: $equippedAccessory, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopItemsTable extends ShopItems
    with TableInfo<$ShopItemsTable, ShopItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceCoinsMeta = const VerificationMeta(
    'priceCoins',
  );
  @override
  late final GeneratedColumn<int> priceCoins = GeneratedColumn<int>(
    'price_coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  @override
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockLevelMeta = const VerificationMeta(
    'unlockLevel',
  );
  @override
  late final GeneratedColumn<int> unlockLevel = GeneratedColumn<int>(
    'unlock_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    priceCoins,
    assetPath,
    unlockLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('price_coins')) {
      context.handle(
        _priceCoinsMeta,
        priceCoins.isAcceptableOrUnknown(data['price_coins']!, _priceCoinsMeta),
      );
    } else if (isInserting) {
      context.missing(_priceCoinsMeta);
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    } else if (isInserting) {
      context.missing(_assetPathMeta);
    }
    if (data.containsKey('unlock_level')) {
      context.handle(
        _unlockLevelMeta,
        unlockLevel.isAcceptableOrUnknown(
          data['unlock_level']!,
          _unlockLevelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      priceCoins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_coins'],
      )!,
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      )!,
      unlockLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlock_level'],
      )!,
    );
  }

  @override
  $ShopItemsTable createAlias(String alias) {
    return $ShopItemsTable(attachedDatabase, alias);
  }
}

class ShopItemRow extends DataClass implements Insertable<ShopItemRow> {
  final String id;
  final String name;
  final String category;
  final int priceCoins;
  final String assetPath;
  final int unlockLevel;
  const ShopItemRow({
    required this.id,
    required this.name,
    required this.category,
    required this.priceCoins,
    required this.assetPath,
    required this.unlockLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['price_coins'] = Variable<int>(priceCoins);
    map['asset_path'] = Variable<String>(assetPath);
    map['unlock_level'] = Variable<int>(unlockLevel);
    return map;
  }

  ShopItemsCompanion toCompanion(bool nullToAbsent) {
    return ShopItemsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      priceCoins: Value(priceCoins),
      assetPath: Value(assetPath),
      unlockLevel: Value(unlockLevel),
    );
  }

  factory ShopItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopItemRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      priceCoins: serializer.fromJson<int>(json['priceCoins']),
      assetPath: serializer.fromJson<String>(json['assetPath']),
      unlockLevel: serializer.fromJson<int>(json['unlockLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'priceCoins': serializer.toJson<int>(priceCoins),
      'assetPath': serializer.toJson<String>(assetPath),
      'unlockLevel': serializer.toJson<int>(unlockLevel),
    };
  }

  ShopItemRow copyWith({
    String? id,
    String? name,
    String? category,
    int? priceCoins,
    String? assetPath,
    int? unlockLevel,
  }) => ShopItemRow(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    priceCoins: priceCoins ?? this.priceCoins,
    assetPath: assetPath ?? this.assetPath,
    unlockLevel: unlockLevel ?? this.unlockLevel,
  );
  ShopItemRow copyWithCompanion(ShopItemsCompanion data) {
    return ShopItemRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      priceCoins: data.priceCoins.present
          ? data.priceCoins.value
          : this.priceCoins,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
      unlockLevel: data.unlockLevel.present
          ? data.unlockLevel.value
          : this.unlockLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopItemRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('priceCoins: $priceCoins, ')
          ..write('assetPath: $assetPath, ')
          ..write('unlockLevel: $unlockLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, priceCoins, assetPath, unlockLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopItemRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.priceCoins == this.priceCoins &&
          other.assetPath == this.assetPath &&
          other.unlockLevel == this.unlockLevel);
}

class ShopItemsCompanion extends UpdateCompanion<ShopItemRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<int> priceCoins;
  final Value<String> assetPath;
  final Value<int> unlockLevel;
  final Value<int> rowid;
  const ShopItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.priceCoins = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.unlockLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopItemsCompanion.insert({
    required String id,
    required String name,
    required String category,
    required int priceCoins,
    required String assetPath,
    this.unlockLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       priceCoins = Value(priceCoins),
       assetPath = Value(assetPath);
  static Insertable<ShopItemRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? priceCoins,
    Expression<String>? assetPath,
    Expression<int>? unlockLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (priceCoins != null) 'price_coins': priceCoins,
      if (assetPath != null) 'asset_path': assetPath,
      if (unlockLevel != null) 'unlock_level': unlockLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<int>? priceCoins,
    Value<String>? assetPath,
    Value<int>? unlockLevel,
    Value<int>? rowid,
  }) {
    return ShopItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      priceCoins: priceCoins ?? this.priceCoins,
      assetPath: assetPath ?? this.assetPath,
      unlockLevel: unlockLevel ?? this.unlockLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (priceCoins.present) {
      map['price_coins'] = Variable<int>(priceCoins.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    if (unlockLevel.present) {
      map['unlock_level'] = Variable<int>(unlockLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('priceCoins: $priceCoins, ')
          ..write('assetPath: $assetPath, ')
          ..write('unlockLevel: $unlockLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shop_items (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _acquiredAtMeta = const VerificationMeta(
    'acquiredAt',
  );
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
    'acquired_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    itemId,
    quantity,
    acquiredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
        _acquiredAtMeta,
        acquiredAt.isAcceptableOrUnknown(data['acquired_at']!, _acquiredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_acquiredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId, itemId},
  ];
  @override
  InventoryItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      acquiredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquired_at'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItemRow extends DataClass
    implements Insertable<InventoryItemRow> {
  final int id;
  final String userId;
  final String itemId;
  final int quantity;
  final DateTime acquiredAt;
  const InventoryItemRow({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.quantity,
    required this.acquiredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['item_id'] = Variable<String>(itemId);
    map['quantity'] = Variable<int>(quantity);
    map['acquired_at'] = Variable<DateTime>(acquiredAt);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      userId: Value(userId),
      itemId: Value(itemId),
      quantity: Value(quantity),
      acquiredAt: Value(acquiredAt),
    );
  }

  factory InventoryItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItemRow(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      acquiredAt: serializer.fromJson<DateTime>(json['acquiredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'itemId': serializer.toJson<String>(itemId),
      'quantity': serializer.toJson<int>(quantity),
      'acquiredAt': serializer.toJson<DateTime>(acquiredAt),
    };
  }

  InventoryItemRow copyWith({
    int? id,
    String? userId,
    String? itemId,
    int? quantity,
    DateTime? acquiredAt,
  }) => InventoryItemRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    itemId: itemId ?? this.itemId,
    quantity: quantity ?? this.quantity,
    acquiredAt: acquiredAt ?? this.acquiredAt,
  );
  InventoryItemRow copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItemRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      acquiredAt: data.acquiredAt.present
          ? data.acquiredAt.value
          : this.acquiredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('acquiredAt: $acquiredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, itemId, quantity, acquiredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItemRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.itemId == this.itemId &&
          other.quantity == this.quantity &&
          other.acquiredAt == this.acquiredAt);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItemRow> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> itemId;
  final Value<int> quantity;
  final Value<DateTime> acquiredAt;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.acquiredAt = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String itemId,
    this.quantity = const Value.absent(),
    required DateTime acquiredAt,
  }) : userId = Value(userId),
       itemId = Value(itemId),
       acquiredAt = Value(acquiredAt);
  static Insertable<InventoryItemRow> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? itemId,
    Expression<int>? quantity,
    Expression<DateTime>? acquiredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (itemId != null) 'item_id': itemId,
      if (quantity != null) 'quantity': quantity,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? itemId,
    Value<int>? quantity,
    Value<DateTime>? acquiredAt,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      acquiredAt: acquiredAt ?? this.acquiredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('acquiredAt: $acquiredAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ReminderSettingsTable reminderSettings = $ReminderSettingsTable(
    this,
  );
  late final $HydrationGoalsTable hydrationGoals = $HydrationGoalsTable(this);
  late final $WaterIntakesTable waterIntakes = $WaterIntakesTable(this);
  late final $DailyProgressTable dailyProgress = $DailyProgressTable(this);
  late final $GamificationProfilesTable gamificationProfiles =
      $GamificationProfilesTable(this);
  late final $RewardTransactionsTable rewardTransactions =
      $RewardTransactionsTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $UserAchievementsTable userAchievements = $UserAchievementsTable(
    this,
  );
  late final $MissionsTable missions = $MissionsTable(this);
  late final $UserMissionsTable userMissions = $UserMissionsTable(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $ShopItemsTable shopItems = $ShopItemsTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final Index idxIntakesUserDate = Index(
    'idx_intakes_user_date',
    'CREATE INDEX idx_intakes_user_date ON water_intakes (user_id, local_date)',
  );
  late final Index idxRewardsUserSourceDate = Index(
    'idx_rewards_user_source_date',
    'CREATE INDEX idx_rewards_user_source_date ON reward_transactions (user_id, source, local_date)',
  );
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final HydrationDao hydrationDao = HydrationDao(this as AppDatabase);
  late final GamificationDao gamificationDao = GamificationDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    reminderSettings,
    hydrationGoals,
    waterIntakes,
    dailyProgress,
    gamificationProfiles,
    rewardTransactions,
    achievements,
    userAchievements,
    missions,
    userMissions,
    pets,
    shopItems,
    inventoryItems,
    idxIntakesUserDate,
    idxRewardsUserSourceDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminder_settings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('hydration_goals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('water_intakes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('daily_progress', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gamification_profiles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reward_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_achievements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_missions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('inventory_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  Value<String?> name,
  Value<String?> email,
  Value<double?> weightKg,
  Value<String> unitSystem,
  Value<bool> isGuest,
  Value<bool> onboardingCompleted,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String?> name,
  Value<String?> email,
  Value<double?> weightKg,
  Value<String> unitSystem,
  Value<bool> isGuest,
  Value<bool> onboardingCompleted,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UserRow> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReminderSettingsTable, List<ReminderSettingsRow>>
  _reminderSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminderSettings,
    aliasName: 'users__id__reminder_settings__user_id',
  );

  $$ReminderSettingsTableProcessedTableManager get reminderSettingsRefs {
    final manager = $$ReminderSettingsTableTableManager(
      $_db,
      $_db.reminderSettings,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reminderSettingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HydrationGoalsTable, List<HydrationGoalRow>>
  _hydrationGoalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.hydrationGoals,
    aliasName: 'users__id__hydration_goals__user_id',
  );

  $$HydrationGoalsTableProcessedTableManager get hydrationGoalsRefs {
    final manager = $$HydrationGoalsTableTableManager(
      $_db,
      $_db.hydrationGoals,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hydrationGoalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WaterIntakesTable, List<WaterIntakeRow>>
  _waterIntakesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.waterIntakes,
    aliasName: 'users__id__water_intakes__user_id',
  );

  $$WaterIntakesTableProcessedTableManager get waterIntakesRefs {
    final manager = $$WaterIntakesTableTableManager(
      $_db,
      $_db.waterIntakes,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_waterIntakesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyProgressTable, List<DailyProgressRow>>
  _dailyProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyProgress,
    aliasName: 'users__id__daily_progress__user_id',
  );

  $$DailyProgressTableProcessedTableManager get dailyProgressRefs {
    final manager = $$DailyProgressTableTableManager(
      $_db,
      $_db.dailyProgress,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GamificationProfilesTable,
    List<GamificationProfileRow>
  >
  _gamificationProfilesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gamificationProfiles,
        aliasName: 'users__id__gamification_profiles__user_id',
      );

  $$GamificationProfilesTableProcessedTableManager
  get gamificationProfilesRefs {
    final manager = $$GamificationProfilesTableTableManager(
      $_db,
      $_db.gamificationProfiles,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gamificationProfilesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RewardTransactionsTable,
    List<RewardTransactionRow>
  >
  _rewardTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.rewardTransactions,
        aliasName: 'users__id__reward_transactions__user_id',
      );

  $$RewardTransactionsTableProcessedTableManager get rewardTransactionsRefs {
    final manager = $$RewardTransactionsTableTableManager(
      $_db,
      $_db.rewardTransactions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rewardTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserAchievementsTable, List<UserAchievementRow>>
  _userAchievementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAchievements,
    aliasName: 'users__id__user_achievements__user_id',
  );

  $$UserAchievementsTableProcessedTableManager get userAchievementsRefs {
    final manager = $$UserAchievementsTableTableManager(
      $_db,
      $_db.userAchievements,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userAchievementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserMissionsTable, List<UserMissionRow>>
  _userMissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userMissions,
    aliasName: 'users__id__user_missions__user_id',
  );

  $$UserMissionsTableProcessedTableManager get userMissionsRefs {
    final manager = $$UserMissionsTableTableManager(
      $_db,
      $_db.userMissions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userMissionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PetsTable, List<PetRow>> _petsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pets,
    aliasName: 'users__id__pets__user_id',
  );

  $$PetsTableProcessedTableManager get petsRefs {
    final manager = $$PetsTableTableManager(
      $_db,
      $_db.pets,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_petsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InventoryItemsTable, List<InventoryItemRow>>
  _inventoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryItems,
    aliasName: 'users__id__inventory_items__user_id',
  );

  $$InventoryItemsTableProcessedTableManager get inventoryItemsRefs {
    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reminderSettingsRefs(
    Expression<bool> Function($$ReminderSettingsTableFilterComposer f) f,
  ) {
    final $$ReminderSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderSettings,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderSettingsTableFilterComposer(
            $db: $db,
            $table: $db.reminderSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> hydrationGoalsRefs(
    Expression<bool> Function($$HydrationGoalsTableFilterComposer f) f,
  ) {
    final $$HydrationGoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hydrationGoals,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HydrationGoalsTableFilterComposer(
            $db: $db,
            $table: $db.hydrationGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waterIntakesRefs(
    Expression<bool> Function($$WaterIntakesTableFilterComposer f) f,
  ) {
    final $$WaterIntakesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterIntakes,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterIntakesTableFilterComposer(
            $db: $db,
            $table: $db.waterIntakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyProgressRefs(
    Expression<bool> Function($$DailyProgressTableFilterComposer f) f,
  ) {
    final $$DailyProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyProgressTableFilterComposer(
            $db: $db,
            $table: $db.dailyProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gamificationProfilesRefs(
    Expression<bool> Function($$GamificationProfilesTableFilterComposer f) f,
  ) {
    final $$GamificationProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gamificationProfiles,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GamificationProfilesTableFilterComposer(
            $db: $db,
            $table: $db.gamificationProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> rewardTransactionsRefs(
    Expression<bool> Function($$RewardTransactionsTableFilterComposer f) f,
  ) {
    final $$RewardTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rewardTransactions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RewardTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.rewardTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userAchievementsRefs(
    Expression<bool> Function($$UserAchievementsTableFilterComposer f) f,
  ) {
    final $$UserAchievementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableFilterComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userMissionsRefs(
    Expression<bool> Function($$UserMissionsTableFilterComposer f) f,
  ) {
    final $$UserMissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userMissions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserMissionsTableFilterComposer(
            $db: $db,
            $table: $db.userMissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> petsRefs(
    Expression<bool> Function($$PetsTableFilterComposer f) f,
  ) {
    final $$PetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableFilterComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryItemsRefs(
    Expression<bool> Function($$InventoryItemsTableFilterComposer f) f,
  ) {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGuest =>
      $composableBuilder(column: $table.isGuest, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> reminderSettingsRefs<T extends Object>(
    Expression<T> Function($$ReminderSettingsTableAnnotationComposer a) f,
  ) {
    final $$ReminderSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderSettings,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.reminderSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> hydrationGoalsRefs<T extends Object>(
    Expression<T> Function($$HydrationGoalsTableAnnotationComposer a) f,
  ) {
    final $$HydrationGoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hydrationGoals,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HydrationGoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.hydrationGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waterIntakesRefs<T extends Object>(
    Expression<T> Function($$WaterIntakesTableAnnotationComposer a) f,
  ) {
    final $$WaterIntakesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterIntakes,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterIntakesTableAnnotationComposer(
            $db: $db,
            $table: $db.waterIntakes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyProgressRefs<T extends Object>(
    Expression<T> Function($$DailyProgressTableAnnotationComposer a) f,
  ) {
    final $$DailyProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gamificationProfilesRefs<T extends Object>(
    Expression<T> Function($$GamificationProfilesTableAnnotationComposer a) f,
  ) {
    final $$GamificationProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gamificationProfiles,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GamificationProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.gamificationProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> rewardTransactionsRefs<T extends Object>(
    Expression<T> Function($$RewardTransactionsTableAnnotationComposer a) f,
  ) {
    final $$RewardTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.rewardTransactions,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RewardTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.rewardTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userAchievementsRefs<T extends Object>(
    Expression<T> Function($$UserAchievementsTableAnnotationComposer a) f,
  ) {
    final $$UserAchievementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userMissionsRefs<T extends Object>(
    Expression<T> Function($$UserMissionsTableAnnotationComposer a) f,
  ) {
    final $$UserMissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userMissions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserMissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.userMissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> petsRefs<T extends Object>(
    Expression<T> Function($$PetsTableAnnotationComposer a) f,
  ) {
    final $$PetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pets,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PetsTableAnnotationComposer(
            $db: $db,
            $table: $db.pets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryItemsRefs<T extends Object>(
    Expression<T> Function($$InventoryItemsTableAnnotationComposer a) f,
  ) {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, $$UsersTableReferences),
          UserRow,
          PrefetchHooks Function({
            bool reminderSettingsRefs,
            bool hydrationGoalsRefs,
            bool waterIntakesRefs,
            bool dailyProgressRefs,
            bool gamificationProfilesRefs,
            bool rewardTransactionsRefs,
            bool userAchievementsRefs,
            bool userMissionsRefs,
            bool petsRefs,
            bool inventoryItemsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<bool> isGuest = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                weightKg: weightKg,
                unitSystem: unitSystem,
                isGuest: isGuest,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<bool> isGuest = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                weightKg: weightKg,
                unitSystem: unitSystem,
                isGuest: isGuest,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, UserRow>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                reminderSettingsRefs = false,
                hydrationGoalsRefs = false,
                waterIntakesRefs = false,
                dailyProgressRefs = false,
                gamificationProfilesRefs = false,
                rewardTransactionsRefs = false,
                userAchievementsRefs = false,
                userMissionsRefs = false,
                petsRefs = false,
                inventoryItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reminderSettingsRefs) db.reminderSettings,
                    if (hydrationGoalsRefs) db.hydrationGoals,
                    if (waterIntakesRefs) db.waterIntakes,
                    if (dailyProgressRefs) db.dailyProgress,
                    if (gamificationProfilesRefs) db.gamificationProfiles,
                    if (rewardTransactionsRefs) db.rewardTransactions,
                    if (userAchievementsRefs) db.userAchievements,
                    if (userMissionsRefs) db.userMissions,
                    if (petsRefs) db.pets,
                    if (inventoryItemsRefs) db.inventoryItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reminderSettingsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          ReminderSettingsRow,
                          $ReminderSettingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._reminderSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).reminderSettingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (hydrationGoalsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          HydrationGoalRow,
                          $HydrationGoalsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._hydrationGoalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).hydrationGoalsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (waterIntakesRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          WaterIntakeRow,
                          $WaterIntakesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._waterIntakesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).waterIntakesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (dailyProgressRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          DailyProgressRow,
                          $DailyProgressTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._dailyProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyProgressRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (gamificationProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          GamificationProfileRow,
                          $GamificationProfilesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._gamificationProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).gamificationProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (rewardTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          RewardTransactionRow,
                          $RewardTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._rewardTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).rewardTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (userAchievementsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          UserAchievementRow,
                          $UserAchievementsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._userAchievementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userAchievementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (userMissionsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          UserMissionRow,
                          $UserMissionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._userMissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userMissionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (petsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          PetRow,
                          $PetsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._petsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).petsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (inventoryItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserRow,
                          $UsersTable,
                          InventoryItemRow,
                          $InventoryItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._inventoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, $$UsersTableReferences),
      UserRow,
      PrefetchHooks Function({
        bool reminderSettingsRefs,
        bool hydrationGoalsRefs,
        bool waterIntakesRefs,
        bool dailyProgressRefs,
        bool gamificationProfilesRefs,
        bool rewardTransactionsRefs,
        bool userAchievementsRefs,
        bool userMissionsRefs,
        bool petsRefs,
        bool inventoryItemsRefs,
      })
    >;
typedef $$ReminderSettingsTableCreateCompanionBuilder =
    ReminderSettingsCompanion Function({
      required String userId,
      Value<bool> enabled,
      required int startMinutes,
      required int endMinutes,
      required int intervalMinutes,
      Value<String> weekdays,
      required int snoozeMinutes,
      Value<int> rowid,
    });
typedef $$ReminderSettingsTableUpdateCompanionBuilder =
    ReminderSettingsCompanion Function({
      Value<String> userId,
      Value<bool> enabled,
      Value<int> startMinutes,
      Value<int> endMinutes,
      Value<int> intervalMinutes,
      Value<String> weekdays,
      Value<int> snoozeMinutes,
      Value<int> rowid,
    });

final class $$ReminderSettingsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReminderSettingsTable,
          ReminderSettingsRow
        > {
  $$ReminderSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('reminder_settings__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReminderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderSettingsTable,
          ReminderSettingsRow,
          $$ReminderSettingsTableFilterComposer,
          $$ReminderSettingsTableOrderingComposer,
          $$ReminderSettingsTableAnnotationComposer,
          $$ReminderSettingsTableCreateCompanionBuilder,
          $$ReminderSettingsTableUpdateCompanionBuilder,
          (ReminderSettingsRow, $$ReminderSettingsTableReferences),
          ReminderSettingsRow,
          PrefetchHooks Function({bool userId})
        > {
  $$ReminderSettingsTableTableManager(
    _$AppDatabase db,
    $ReminderSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> startMinutes = const Value.absent(),
                Value<int> endMinutes = const Value.absent(),
                Value<int> intervalMinutes = const Value.absent(),
                Value<String> weekdays = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderSettingsCompanion(
                userId: userId,
                enabled: enabled,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                intervalMinutes: intervalMinutes,
                weekdays: weekdays,
                snoozeMinutes: snoozeMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<bool> enabled = const Value.absent(),
                required int startMinutes,
                required int endMinutes,
                required int intervalMinutes,
                Value<String> weekdays = const Value.absent(),
                required int snoozeMinutes,
                Value<int> rowid = const Value.absent(),
              }) => ReminderSettingsCompanion.insert(
                userId: userId,
                enabled: enabled,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                intervalMinutes: intervalMinutes,
                weekdays: weekdays,
                snoozeMinutes: snoozeMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReminderSettingsTable, ReminderSettingsRow>(
                    table,
                  ),
                  $$ReminderSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$ReminderSettingsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$ReminderSettingsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReminderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderSettingsTable,
      ReminderSettingsRow,
      $$ReminderSettingsTableFilterComposer,
      $$ReminderSettingsTableOrderingComposer,
      $$ReminderSettingsTableAnnotationComposer,
      $$ReminderSettingsTableCreateCompanionBuilder,
      $$ReminderSettingsTableUpdateCompanionBuilder,
      (ReminderSettingsRow, $$ReminderSettingsTableReferences),
      ReminderSettingsRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$HydrationGoalsTableCreateCompanionBuilder =
    HydrationGoalsCompanion Function({
      Value<int> id,
      required String userId,
      required int dailyGoalMl,
      required String startDate,
      Value<String?> endDate,
    });
typedef $$HydrationGoalsTableUpdateCompanionBuilder =
    HydrationGoalsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> dailyGoalMl,
      Value<String> startDate,
      Value<String?> endDate,
    });

final class $$HydrationGoalsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HydrationGoalsTable, HydrationGoalRow> {
  $$HydrationGoalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('hydration_goals__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HydrationGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $HydrationGoalsTable> {
  $$HydrationGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyGoalMl => $composableBuilder(
    column: $table.dailyGoalMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HydrationGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $HydrationGoalsTable> {
  $$HydrationGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyGoalMl => $composableBuilder(
    column: $table.dailyGoalMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HydrationGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HydrationGoalsTable> {
  $$HydrationGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dailyGoalMl => $composableBuilder(
    column: $table.dailyGoalMl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HydrationGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HydrationGoalsTable,
          HydrationGoalRow,
          $$HydrationGoalsTableFilterComposer,
          $$HydrationGoalsTableOrderingComposer,
          $$HydrationGoalsTableAnnotationComposer,
          $$HydrationGoalsTableCreateCompanionBuilder,
          $$HydrationGoalsTableUpdateCompanionBuilder,
          (HydrationGoalRow, $$HydrationGoalsTableReferences),
          HydrationGoalRow,
          PrefetchHooks Function({bool userId})
        > {
  $$HydrationGoalsTableTableManager(
    _$AppDatabase db,
    $HydrationGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HydrationGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HydrationGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HydrationGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> dailyGoalMl = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
              }) => HydrationGoalsCompanion(
                id: id,
                userId: userId,
                dailyGoalMl: dailyGoalMl,
                startDate: startDate,
                endDate: endDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int dailyGoalMl,
                required String startDate,
                Value<String?> endDate = const Value.absent(),
              }) => HydrationGoalsCompanion.insert(
                id: id,
                userId: userId,
                dailyGoalMl: dailyGoalMl,
                startDate: startDate,
                endDate: endDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HydrationGoalsTable, HydrationGoalRow>(table),
                  $$HydrationGoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$HydrationGoalsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$HydrationGoalsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HydrationGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HydrationGoalsTable,
      HydrationGoalRow,
      $$HydrationGoalsTableFilterComposer,
      $$HydrationGoalsTableOrderingComposer,
      $$HydrationGoalsTableAnnotationComposer,
      $$HydrationGoalsTableCreateCompanionBuilder,
      $$HydrationGoalsTableUpdateCompanionBuilder,
      (HydrationGoalRow, $$HydrationGoalsTableReferences),
      HydrationGoalRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$WaterIntakesTableCreateCompanionBuilder =
    WaterIntakesCompanion Function({
      required String id,
      required String userId,
      required int amountMl,
      required DateTime consumedAt,
      required String localDate,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WaterIntakesTableUpdateCompanionBuilder =
    WaterIntakesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<int> amountMl,
      Value<DateTime> consumedAt,
      Value<String> localDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WaterIntakesTableReferences
    extends BaseReferences<_$AppDatabase, $WaterIntakesTable, WaterIntakeRow> {
  $$WaterIntakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('water_intakes__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaterIntakesTableFilterComposer
    extends Composer<_$AppDatabase, $WaterIntakesTable> {
  $$WaterIntakesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get consumedAt => $composableBuilder(
    column: $table.consumedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterIntakesTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterIntakesTable> {
  $$WaterIntakesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMl => $composableBuilder(
    column: $table.amountMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get consumedAt => $composableBuilder(
    column: $table.consumedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterIntakesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterIntakesTable> {
  $$WaterIntakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountMl =>
      $composableBuilder(column: $table.amountMl, builder: (column) => column);

  GeneratedColumn<DateTime> get consumedAt => $composableBuilder(
    column: $table.consumedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterIntakesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterIntakesTable,
          WaterIntakeRow,
          $$WaterIntakesTableFilterComposer,
          $$WaterIntakesTableOrderingComposer,
          $$WaterIntakesTableAnnotationComposer,
          $$WaterIntakesTableCreateCompanionBuilder,
          $$WaterIntakesTableUpdateCompanionBuilder,
          (WaterIntakeRow, $$WaterIntakesTableReferences),
          WaterIntakeRow,
          PrefetchHooks Function({bool userId})
        > {
  $$WaterIntakesTableTableManager(_$AppDatabase db, $WaterIntakesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterIntakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterIntakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterIntakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> amountMl = const Value.absent(),
                Value<DateTime> consumedAt = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WaterIntakesCompanion(
                id: id,
                userId: userId,
                amountMl: amountMl,
                consumedAt: consumedAt,
                localDate: localDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required int amountMl,
                required DateTime consumedAt,
                required String localDate,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WaterIntakesCompanion.insert(
                id: id,
                userId: userId,
                amountMl: amountMl,
                consumedAt: consumedAt,
                localDate: localDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WaterIntakesTable, WaterIntakeRow>(table),
                  $$WaterIntakesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$WaterIntakesTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$WaterIntakesTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaterIntakesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterIntakesTable,
      WaterIntakeRow,
      $$WaterIntakesTableFilterComposer,
      $$WaterIntakesTableOrderingComposer,
      $$WaterIntakesTableAnnotationComposer,
      $$WaterIntakesTableCreateCompanionBuilder,
      $$WaterIntakesTableUpdateCompanionBuilder,
      (WaterIntakeRow, $$WaterIntakesTableReferences),
      WaterIntakeRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$DailyProgressTableCreateCompanionBuilder =
    DailyProgressCompanion Function({
      required String userId,
      required String date,
      required int totalMl,
      required int goalMl,
      required bool completed,
      required double completionPercentage,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DailyProgressTableUpdateCompanionBuilder =
    DailyProgressCompanion Function({
      Value<String> userId,
      Value<String> date,
      Value<int> totalMl,
      Value<int> goalMl,
      Value<bool> completed,
      Value<double> completionPercentage,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$DailyProgressTableReferences
    extends
        BaseReferences<_$AppDatabase, $DailyProgressTable, DailyProgressRow> {
  $$DailyProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('daily_progress__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyProgressTableFilterComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMl => $composableBuilder(
    column: $table.totalMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalMl => $composableBuilder(
    column: $table.goalMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMl => $composableBuilder(
    column: $table.totalMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalMl => $composableBuilder(
    column: $table.goalMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyProgressTable> {
  $$DailyProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get totalMl =>
      $composableBuilder(column: $table.totalMl, builder: (column) => column);

  GeneratedColumn<int> get goalMl =>
      $composableBuilder(column: $table.goalMl, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<double> get completionPercentage => $composableBuilder(
    column: $table.completionPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyProgressTable,
          DailyProgressRow,
          $$DailyProgressTableFilterComposer,
          $$DailyProgressTableOrderingComposer,
          $$DailyProgressTableAnnotationComposer,
          $$DailyProgressTableCreateCompanionBuilder,
          $$DailyProgressTableUpdateCompanionBuilder,
          (DailyProgressRow, $$DailyProgressTableReferences),
          DailyProgressRow,
          PrefetchHooks Function({bool userId})
        > {
  $$DailyProgressTableTableManager(_$AppDatabase db, $DailyProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int> totalMl = const Value.absent(),
                Value<int> goalMl = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<double> completionPercentage = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyProgressCompanion(
                userId: userId,
                date: date,
                totalMl: totalMl,
                goalMl: goalMl,
                completed: completed,
                completionPercentage: completionPercentage,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String date,
                required int totalMl,
                required int goalMl,
                required bool completed,
                required double completionPercentage,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyProgressCompanion.insert(
                userId: userId,
                date: date,
                totalMl: totalMl,
                goalMl: goalMl,
                completed: completed,
                completionPercentage: completionPercentage,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyProgressTable, DailyProgressRow>(table),
                  $$DailyProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$DailyProgressTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$DailyProgressTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DailyProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyProgressTable,
      DailyProgressRow,
      $$DailyProgressTableFilterComposer,
      $$DailyProgressTableOrderingComposer,
      $$DailyProgressTableAnnotationComposer,
      $$DailyProgressTableCreateCompanionBuilder,
      $$DailyProgressTableUpdateCompanionBuilder,
      (DailyProgressRow, $$DailyProgressTableReferences),
      DailyProgressRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$GamificationProfilesTableCreateCompanionBuilder =
    GamificationProfilesCompanion Function({
      required String userId,
      Value<int> totalXp,
      Value<int> level,
      Value<int> coins,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> rowid,
    });
typedef $$GamificationProfilesTableUpdateCompanionBuilder =
    GamificationProfilesCompanion Function({
      Value<String> userId,
      Value<int> totalXp,
      Value<int> level,
      Value<int> coins,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> rowid,
    });

final class $$GamificationProfilesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GamificationProfilesTable,
          GamificationProfileRow
        > {
  $$GamificationProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('gamification_profiles__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GamificationProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $GamificationProfilesTable> {
  $$GamificationProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GamificationProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $GamificationProfilesTable> {
  $$GamificationProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GamificationProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GamificationProfilesTable> {
  $$GamificationProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GamificationProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GamificationProfilesTable,
          GamificationProfileRow,
          $$GamificationProfilesTableFilterComposer,
          $$GamificationProfilesTableOrderingComposer,
          $$GamificationProfilesTableAnnotationComposer,
          $$GamificationProfilesTableCreateCompanionBuilder,
          $$GamificationProfilesTableUpdateCompanionBuilder,
          (GamificationProfileRow, $$GamificationProfilesTableReferences),
          GamificationProfileRow,
          PrefetchHooks Function({bool userId})
        > {
  $$GamificationProfilesTableTableManager(
    _$AppDatabase db,
    $GamificationProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GamificationProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GamificationProfilesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GamificationProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GamificationProfilesCompanion(
                userId: userId,
                totalXp: totalXp,
                level: level,
                coins: coins,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GamificationProfilesCompanion.insert(
                userId: userId,
                totalXp: totalXp,
                level: level,
                coins: coins,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $GamificationProfilesTable,
                    GamificationProfileRow
                  >(table),
                  $$GamificationProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$GamificationProfilesTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$GamificationProfilesTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GamificationProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GamificationProfilesTable,
      GamificationProfileRow,
      $$GamificationProfilesTableFilterComposer,
      $$GamificationProfilesTableOrderingComposer,
      $$GamificationProfilesTableAnnotationComposer,
      $$GamificationProfilesTableCreateCompanionBuilder,
      $$GamificationProfilesTableUpdateCompanionBuilder,
      (GamificationProfileRow, $$GamificationProfilesTableReferences),
      GamificationProfileRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$RewardTransactionsTableCreateCompanionBuilder =
    RewardTransactionsCompanion Function({
      Value<int> id,
      required String userId,
      required String type,
      required int amount,
      required String source,
      required String referenceId,
      required String localDate,
      required DateTime createdAt,
    });
typedef $$RewardTransactionsTableUpdateCompanionBuilder =
    RewardTransactionsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> type,
      Value<int> amount,
      Value<String> source,
      Value<String> referenceId,
      Value<String> localDate,
      Value<DateTime> createdAt,
    });

final class $$RewardTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RewardTransactionsTable,
          RewardTransactionRow
        > {
  $$RewardTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('reward_transactions__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RewardTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardTransactionsTable> {
  $$RewardTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardTransactionsTable> {
  $$RewardTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardTransactionsTable> {
  $$RewardTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RewardTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardTransactionsTable,
          RewardTransactionRow,
          $$RewardTransactionsTableFilterComposer,
          $$RewardTransactionsTableOrderingComposer,
          $$RewardTransactionsTableAnnotationComposer,
          $$RewardTransactionsTableCreateCompanionBuilder,
          $$RewardTransactionsTableUpdateCompanionBuilder,
          (RewardTransactionRow, $$RewardTransactionsTableReferences),
          RewardTransactionRow,
          PrefetchHooks Function({bool userId})
        > {
  $$RewardTransactionsTableTableManager(
    _$AppDatabase db,
    $RewardTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> referenceId = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RewardTransactionsCompanion(
                id: id,
                userId: userId,
                type: type,
                amount: amount,
                source: source,
                referenceId: referenceId,
                localDate: localDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String type,
                required int amount,
                required String source,
                required String referenceId,
                required String localDate,
                required DateTime createdAt,
              }) => RewardTransactionsCompanion.insert(
                id: id,
                userId: userId,
                type: type,
                amount: amount,
                source: source,
                referenceId: referenceId,
                localDate: localDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RewardTransactionsTable, RewardTransactionRow>(
                    table,
                  ),
                  $$RewardTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$RewardTransactionsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$RewardTransactionsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RewardTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardTransactionsTable,
      RewardTransactionRow,
      $$RewardTransactionsTableFilterComposer,
      $$RewardTransactionsTableOrderingComposer,
      $$RewardTransactionsTableAnnotationComposer,
      $$RewardTransactionsTableCreateCompanionBuilder,
      $$RewardTransactionsTableUpdateCompanionBuilder,
      (RewardTransactionRow, $$RewardTransactionsTableReferences),
      RewardTransactionRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required String title,
      required String description,
      required String iconPath,
      required String conditionType,
      required int conditionValue,
      Value<int> xpReward,
      Value<int> coinReward,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> iconPath,
      Value<String> conditionType,
      Value<int> conditionValue,
      Value<int> xpReward,
      Value<int> coinReward,
      Value<int> rowid,
    });

final class $$AchievementsTableReferences
    extends BaseReferences<_$AppDatabase, $AchievementsTable, AchievementRow> {
  $$AchievementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserAchievementsTable, List<UserAchievementRow>>
  _userAchievementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAchievements,
    aliasName: 'achievements__id__user_achievements__achievement_id',
  );

  $$UserAchievementsTableProcessedTableManager get userAchievementsRefs {
    final manager = $$UserAchievementsTableTableManager(
      $_db,
      $_db.userAchievements,
    ).filter((f) => f.achievementId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userAchievementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditionType => $composableBuilder(
    column: $table.conditionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get conditionValue => $composableBuilder(
    column: $table.conditionValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userAchievementsRefs(
    Expression<bool> Function($$UserAchievementsTableFilterComposer f) f,
  ) {
    final $$UserAchievementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.achievementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableFilterComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconPath => $composableBuilder(
    column: $table.iconPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditionType => $composableBuilder(
    column: $table.conditionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get conditionValue => $composableBuilder(
    column: $table.conditionValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  GeneratedColumn<String> get conditionType => $composableBuilder(
    column: $table.conditionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get conditionValue => $composableBuilder(
    column: $table.conditionValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<int> get coinReward => $composableBuilder(
    column: $table.coinReward,
    builder: (column) => column,
  );

  Expression<T> userAchievementsRefs<T extends Object>(
    Expression<T> Function($$UserAchievementsTableAnnotationComposer a) f,
  ) {
    final $$UserAchievementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAchievements,
      getReferencedColumn: (t) => t.achievementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAchievementsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAchievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          AchievementRow,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (AchievementRow, $$AchievementsTableReferences),
          AchievementRow,
          PrefetchHooks Function({bool userAchievementsRefs})
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> iconPath = const Value.absent(),
                Value<String> conditionType = const Value.absent(),
                Value<int> conditionValue = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<int> coinReward = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                title: title,
                description: description,
                iconPath: iconPath,
                conditionType: conditionType,
                conditionValue: conditionValue,
                xpReward: xpReward,
                coinReward: coinReward,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String iconPath,
                required String conditionType,
                required int conditionValue,
                Value<int> xpReward = const Value.absent(),
                Value<int> coinReward = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                title: title,
                description: description,
                iconPath: iconPath,
                conditionType: conditionType,
                conditionValue: conditionValue,
                xpReward: xpReward,
                coinReward: coinReward,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementsTable, AchievementRow>(table),
                  $$AchievementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userAchievementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userAchievementsRefs) db.userAchievements,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userAchievementsRefs)
                    await $_getPrefetchedDataByColumns<
                      AchievementRow,
                      $AchievementsTable,
                      UserAchievementRow,
                      $UserAchievementsTable
                    >(
                      currentTable: table,
                      referencedTable: $$AchievementsTableReferences
                          ._userAchievementsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AchievementsTableReferences(
                            db,
                            table,
                            p0,
                          ).userAchievementsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'achievement_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      AchievementRow,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (AchievementRow, $$AchievementsTableReferences),
      AchievementRow,
      PrefetchHooks Function({bool userAchievementsRefs})
    >;
typedef $$UserAchievementsTableCreateCompanionBuilder =
    UserAchievementsCompanion Function({
      required String userId,
      required String achievementId,
      required DateTime unlockedAt,
      Value<int> rowid,
    });
typedef $$UserAchievementsTableUpdateCompanionBuilder =
    UserAchievementsCompanion Function({
      Value<String> userId,
      Value<String> achievementId,
      Value<DateTime> unlockedAt,
      Value<int> rowid,
    });

final class $$UserAchievementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievementRow
        > {
  $$UserAchievementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('user_achievements__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AchievementsTable _achievementIdTable(_$AppDatabase db) => db
      .achievements
      .createAlias('user_achievements__achievement_id__achievements__id');

  $$AchievementsTableProcessedTableManager get achievementId {
    final $_column = $_itemColumn<String>('achievement_id')!;

    final manager = $$AchievementsTableTableManager(
      $_db,
      $_db.achievements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_achievementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AchievementsTableFilterComposer get achievementId {
    final $$AchievementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableFilterComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AchievementsTableOrderingComposer get achievementId {
    final $$AchievementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableOrderingComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AchievementsTableAnnotationComposer get achievementId {
    final $$AchievementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.achievementId,
      referencedTable: $db.achievements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AchievementsTableAnnotationComposer(
            $db: $db,
            $table: $db.achievements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievementRow,
          $$UserAchievementsTableFilterComposer,
          $$UserAchievementsTableOrderingComposer,
          $$UserAchievementsTableAnnotationComposer,
          $$UserAchievementsTableCreateCompanionBuilder,
          $$UserAchievementsTableUpdateCompanionBuilder,
          (UserAchievementRow, $$UserAchievementsTableReferences),
          UserAchievementRow,
          PrefetchHooks Function({bool userId, bool achievementId})
        > {
  $$UserAchievementsTableTableManager(
    _$AppDatabase db,
    $UserAchievementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> achievementId = const Value.absent(),
                Value<DateTime> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion(
                userId: userId,
                achievementId: achievementId,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String achievementId,
                required DateTime unlockedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion.insert(
                userId: userId,
                achievementId: achievementId,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserAchievementsTable, UserAchievementRow>(
                    table,
                  ),
                  $$UserAchievementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, achievementId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$UserAchievementsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$UserAchievementsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (achievementId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.achievementId,
                        referencedTable: $$UserAchievementsTableReferences
                            ._achievementIdTable(db),
                        referencedColumn: $$UserAchievementsTableReferences
                            ._achievementIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserAchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAchievementsTable,
      UserAchievementRow,
      $$UserAchievementsTableFilterComposer,
      $$UserAchievementsTableOrderingComposer,
      $$UserAchievementsTableAnnotationComposer,
      $$UserAchievementsTableCreateCompanionBuilder,
      $$UserAchievementsTableUpdateCompanionBuilder,
      (UserAchievementRow, $$UserAchievementsTableReferences),
      UserAchievementRow,
      PrefetchHooks Function({bool userId, bool achievementId})
    >;
typedef $$MissionsTableCreateCompanionBuilder = MissionsCompanion Function({
  required String id,
  required String title,
  required String description,
  required String period,
  required String metric,
  required int target,
  Value<int> rowid,
});
typedef $$MissionsTableUpdateCompanionBuilder = MissionsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<String> period,
  Value<String> metric,
  Value<int> target,
  Value<int> rowid,
});

final class $$MissionsTableReferences
    extends BaseReferences<_$AppDatabase, $MissionsTable, MissionRow> {
  $$MissionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserMissionsTable, List<UserMissionRow>>
  _userMissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userMissions,
    aliasName: 'missions__id__user_missions__mission_id',
  );

  $$UserMissionsTableProcessedTableManager get userMissionsRefs {
    final manager = $$UserMissionsTableTableManager(
      $_db,
      $_db.userMissions,
    ).filter((f) => f.missionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userMissionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MissionsTableFilterComposer
    extends Composer<_$AppDatabase, $MissionsTable> {
  $$MissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userMissionsRefs(
    Expression<bool> Function($$UserMissionsTableFilterComposer f) f,
  ) {
    final $$UserMissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userMissions,
      getReferencedColumn: (t) => t.missionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserMissionsTableFilterComposer(
            $db: $db,
            $table: $db.userMissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MissionsTable> {
  $$MissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MissionsTable> {
  $$MissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  Expression<T> userMissionsRefs<T extends Object>(
    Expression<T> Function($$UserMissionsTableAnnotationComposer a) f,
  ) {
    final $$UserMissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userMissions,
      getReferencedColumn: (t) => t.missionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserMissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.userMissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MissionsTable,
          MissionRow,
          $$MissionsTableFilterComposer,
          $$MissionsTableOrderingComposer,
          $$MissionsTableAnnotationComposer,
          $$MissionsTableCreateCompanionBuilder,
          $$MissionsTableUpdateCompanionBuilder,
          (MissionRow, $$MissionsTableReferences),
          MissionRow,
          PrefetchHooks Function({bool userMissionsRefs})
        > {
  $$MissionsTableTableManager(_$AppDatabase db, $MissionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MissionsCompanion(
                id: id,
                title: title,
                description: description,
                period: period,
                metric: metric,
                target: target,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String period,
                required String metric,
                required int target,
                Value<int> rowid = const Value.absent(),
              }) => MissionsCompanion.insert(
                id: id,
                title: title,
                description: description,
                period: period,
                metric: metric,
                target: target,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MissionsTable, MissionRow>(table),
                  $$MissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userMissionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userMissionsRefs) db.userMissions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userMissionsRefs)
                    await $_getPrefetchedDataByColumns<
                      MissionRow,
                      $MissionsTable,
                      UserMissionRow,
                      $UserMissionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$MissionsTableReferences
                          ._userMissionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$MissionsTableReferences(
                        db,
                        table,
                        p0,
                      ).userMissionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'mission_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MissionsTable,
      MissionRow,
      $$MissionsTableFilterComposer,
      $$MissionsTableOrderingComposer,
      $$MissionsTableAnnotationComposer,
      $$MissionsTableCreateCompanionBuilder,
      $$MissionsTableUpdateCompanionBuilder,
      (MissionRow, $$MissionsTableReferences),
      MissionRow,
      PrefetchHooks Function({bool userMissionsRefs})
    >;
typedef $$UserMissionsTableCreateCompanionBuilder =
    UserMissionsCompanion Function({
      Value<int> id,
      required String userId,
      required String missionId,
      required String periodStart,
      Value<int> progress,
      Value<bool> completed,
      Value<bool> claimed,
    });
typedef $$UserMissionsTableUpdateCompanionBuilder =
    UserMissionsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> missionId,
      Value<String> periodStart,
      Value<int> progress,
      Value<bool> completed,
      Value<bool> claimed,
    });

final class $$UserMissionsTableReferences
    extends BaseReferences<_$AppDatabase, $UserMissionsTable, UserMissionRow> {
  $$UserMissionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('user_missions__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MissionsTable _missionIdTable(_$AppDatabase db) =>
      db.missions.createAlias('user_missions__mission_id__missions__id');

  $$MissionsTableProcessedTableManager get missionId {
    final $_column = $_itemColumn<String>('mission_id')!;

    final manager = $$MissionsTableTableManager(
      $_db,
      $_db.missions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_missionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserMissionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserMissionsTable> {
  $$UserMissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MissionsTableFilterComposer get missionId {
    final $$MissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.missionId,
      referencedTable: $db.missions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MissionsTableFilterComposer(
            $db: $db,
            $table: $db.missions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserMissionsTable> {
  $$UserMissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MissionsTableOrderingComposer get missionId {
    final $$MissionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.missionId,
      referencedTable: $db.missions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MissionsTableOrderingComposer(
            $db: $db,
            $table: $db.missions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserMissionsTable> {
  $$UserMissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<bool> get claimed =>
      $composableBuilder(column: $table.claimed, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MissionsTableAnnotationComposer get missionId {
    final $$MissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.missionId,
      referencedTable: $db.missions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.missions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserMissionsTable,
          UserMissionRow,
          $$UserMissionsTableFilterComposer,
          $$UserMissionsTableOrderingComposer,
          $$UserMissionsTableAnnotationComposer,
          $$UserMissionsTableCreateCompanionBuilder,
          $$UserMissionsTableUpdateCompanionBuilder,
          (UserMissionRow, $$UserMissionsTableReferences),
          UserMissionRow,
          PrefetchHooks Function({bool userId, bool missionId})
        > {
  $$UserMissionsTableTableManager(_$AppDatabase db, $UserMissionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserMissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserMissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserMissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> missionId = const Value.absent(),
                Value<String> periodStart = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
              }) => UserMissionsCompanion(
                id: id,
                userId: userId,
                missionId: missionId,
                periodStart: periodStart,
                progress: progress,
                completed: completed,
                claimed: claimed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String missionId,
                required String periodStart,
                Value<int> progress = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
              }) => UserMissionsCompanion.insert(
                id: id,
                userId: userId,
                missionId: missionId,
                periodStart: periodStart,
                progress: progress,
                completed: completed,
                claimed: claimed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserMissionsTable, UserMissionRow>(table),
                  $$UserMissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, missionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$UserMissionsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$UserMissionsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (missionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.missionId,
                        referencedTable: $$UserMissionsTableReferences
                            ._missionIdTable(db),
                        referencedColumn: $$UserMissionsTableReferences
                            ._missionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserMissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserMissionsTable,
      UserMissionRow,
      $$UserMissionsTableFilterComposer,
      $$UserMissionsTableOrderingComposer,
      $$UserMissionsTableAnnotationComposer,
      $$UserMissionsTableCreateCompanionBuilder,
      $$UserMissionsTableUpdateCompanionBuilder,
      (UserMissionRow, $$UserMissionsTableReferences),
      UserMissionRow,
      PrefetchHooks Function({bool userId, bool missionId})
    >;
typedef $$PetsTableCreateCompanionBuilder = PetsCompanion Function({
  required String userId,
  Value<String> species,
  Value<int> evolutionStage,
  Value<int> xp,
  Value<int> happiness,
  Value<String> mood,
  Value<String?> equippedAccessory,
  Value<int> rowid,
});
typedef $$PetsTableUpdateCompanionBuilder = PetsCompanion Function({
  Value<String> userId,
  Value<String> species,
  Value<int> evolutionStage,
  Value<int> xp,
  Value<int> happiness,
  Value<String> mood,
  Value<String?> equippedAccessory,
  Value<int> rowid,
});

final class $$PetsTableReferences
    extends BaseReferences<_$AppDatabase, $PetsTable, PetRow> {
  $$PetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('pets__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PetsTableFilterComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get happiness => $composableBuilder(
    column: $table.happiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equippedAccessory => $composableBuilder(
    column: $table.equippedAccessory,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetsTableOrderingComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get happiness => $composableBuilder(
    column: $table.happiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equippedAccessory => $composableBuilder(
    column: $table.equippedAccessory,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<int> get evolutionStage => $composableBuilder(
    column: $table.evolutionStage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get happiness =>
      $composableBuilder(column: $table.happiness, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get equippedAccessory => $composableBuilder(
    column: $table.equippedAccessory,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetsTable,
          PetRow,
          $$PetsTableFilterComposer,
          $$PetsTableOrderingComposer,
          $$PetsTableAnnotationComposer,
          $$PetsTableCreateCompanionBuilder,
          $$PetsTableUpdateCompanionBuilder,
          (PetRow, $$PetsTableReferences),
          PetRow,
          PrefetchHooks Function({bool userId})
        > {
  $$PetsTableTableManager(_$AppDatabase db, $PetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<int> evolutionStage = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> happiness = const Value.absent(),
                Value<String> mood = const Value.absent(),
                Value<String?> equippedAccessory = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PetsCompanion(
                userId: userId,
                species: species,
                evolutionStage: evolutionStage,
                xp: xp,
                happiness: happiness,
                mood: mood,
                equippedAccessory: equippedAccessory,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<String> species = const Value.absent(),
                Value<int> evolutionStage = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> happiness = const Value.absent(),
                Value<String> mood = const Value.absent(),
                Value<String?> equippedAccessory = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PetsCompanion.insert(
                userId: userId,
                species: species,
                evolutionStage: evolutionStage,
                xp: xp,
                happiness: happiness,
                mood: mood,
                equippedAccessory: equippedAccessory,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PetsTable, PetRow>(table),
                  $$PetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$PetsTableReferences._userIdTable(db),
                        referencedColumn: $$PetsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetsTable,
      PetRow,
      $$PetsTableFilterComposer,
      $$PetsTableOrderingComposer,
      $$PetsTableAnnotationComposer,
      $$PetsTableCreateCompanionBuilder,
      $$PetsTableUpdateCompanionBuilder,
      (PetRow, $$PetsTableReferences),
      PetRow,
      PrefetchHooks Function({bool userId})
    >;
typedef $$ShopItemsTableCreateCompanionBuilder = ShopItemsCompanion Function({
  required String id,
  required String name,
  required String category,
  required int priceCoins,
  required String assetPath,
  Value<int> unlockLevel,
  Value<int> rowid,
});
typedef $$ShopItemsTableUpdateCompanionBuilder = ShopItemsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<int> priceCoins,
  Value<String> assetPath,
  Value<int> unlockLevel,
  Value<int> rowid,
});

final class $$ShopItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ShopItemsTable, ShopItemRow> {
  $$ShopItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InventoryItemsTable, List<InventoryItemRow>>
  _inventoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryItems,
    aliasName: 'shop_items__id__inventory_items__item_id',
  );

  $$InventoryItemsTableProcessedTableManager get inventoryItemsRefs {
    final manager = $$InventoryItemsTableTableManager(
      $_db,
      $_db.inventoryItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ShopItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShopItemsTable> {
  $$ShopItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceCoins => $composableBuilder(
    column: $table.priceCoins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unlockLevel => $composableBuilder(
    column: $table.unlockLevel,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> inventoryItemsRefs(
    Expression<bool> Function($$InventoryItemsTableFilterComposer f) f,
  ) {
    final $$InventoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShopItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopItemsTable> {
  $$ShopItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceCoins => $composableBuilder(
    column: $table.priceCoins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unlockLevel => $composableBuilder(
    column: $table.unlockLevel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopItemsTable> {
  $$ShopItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get priceCoins => $composableBuilder(
    column: $table.priceCoins,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  GeneratedColumn<int> get unlockLevel => $composableBuilder(
    column: $table.unlockLevel,
    builder: (column) => column,
  );

  Expression<T> inventoryItemsRefs<T extends Object>(
    Expression<T> Function($$InventoryItemsTableAnnotationComposer a) f,
  ) {
    final $$InventoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShopItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopItemsTable,
          ShopItemRow,
          $$ShopItemsTableFilterComposer,
          $$ShopItemsTableOrderingComposer,
          $$ShopItemsTableAnnotationComposer,
          $$ShopItemsTableCreateCompanionBuilder,
          $$ShopItemsTableUpdateCompanionBuilder,
          (ShopItemRow, $$ShopItemsTableReferences),
          ShopItemRow,
          PrefetchHooks Function({bool inventoryItemsRefs})
        > {
  $$ShopItemsTableTableManager(_$AppDatabase db, $ShopItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> priceCoins = const Value.absent(),
                Value<String> assetPath = const Value.absent(),
                Value<int> unlockLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopItemsCompanion(
                id: id,
                name: name,
                category: category,
                priceCoins: priceCoins,
                assetPath: assetPath,
                unlockLevel: unlockLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                required int priceCoins,
                required String assetPath,
                Value<int> unlockLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopItemsCompanion.insert(
                id: id,
                name: name,
                category: category,
                priceCoins: priceCoins,
                assetPath: assetPath,
                unlockLevel: unlockLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopItemsTable, ShopItemRow>(table),
                  $$ShopItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({inventoryItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (inventoryItemsRefs) db.inventoryItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (inventoryItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      ShopItemRow,
                      $ShopItemsTable,
                      InventoryItemRow,
                      $InventoryItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ShopItemsTableReferences
                          ._inventoryItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ShopItemsTableReferences(
                            db,
                            table,
                            p0,
                          ).inventoryItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'item_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ShopItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopItemsTable,
      ShopItemRow,
      $$ShopItemsTableFilterComposer,
      $$ShopItemsTableOrderingComposer,
      $$ShopItemsTableAnnotationComposer,
      $$ShopItemsTableCreateCompanionBuilder,
      $$ShopItemsTableUpdateCompanionBuilder,
      (ShopItemRow, $$ShopItemsTableReferences),
      ShopItemRow,
      PrefetchHooks Function({bool inventoryItemsRefs})
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      required String userId,
      required String itemId,
      Value<int> quantity,
      required DateTime acquiredAt,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> itemId,
      Value<int> quantity,
      Value<DateTime> acquiredAt,
    });

final class $$InventoryItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItemRow> {
  $$InventoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('inventory_items__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ShopItemsTable _itemIdTable(_$AppDatabase db) =>
      db.shopItems.createAlias('inventory_items__item_id__shop_items__id');

  $$ShopItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<String>('item_id')!;

    final manager = $$ShopItemsTableTableManager(
      $_db,
      $_db.shopItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShopItemsTableFilterComposer get itemId {
    final $$ShopItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.shopItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShopItemsTableFilterComposer(
            $db: $db,
            $table: $db.shopItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShopItemsTableOrderingComposer get itemId {
    final $$ShopItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.shopItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShopItemsTableOrderingComposer(
            $db: $db,
            $table: $db.shopItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
    column: $table.acquiredAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShopItemsTableAnnotationComposer get itemId {
    final $$ShopItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.shopItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShopItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.shopItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItemRow,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (InventoryItemRow, $$InventoryItemsTableReferences),
          InventoryItemRow,
          PrefetchHooks Function({bool userId, bool itemId})
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> acquiredAt = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                userId: userId,
                itemId: itemId,
                quantity: quantity,
                acquiredAt: acquiredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String itemId,
                Value<int> quantity = const Value.absent(),
                required DateTime acquiredAt,
              }) => InventoryItemsCompanion.insert(
                id: id,
                userId: userId,
                itemId: itemId,
                quantity: quantity,
                acquiredAt: acquiredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryItemsTable, InventoryItemRow>(table),
                  $$InventoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$InventoryItemsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$InventoryItemsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (itemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.itemId,
                        referencedTable: $$InventoryItemsTableReferences
                            ._itemIdTable(db),
                        referencedColumn: $$InventoryItemsTableReferences
                            ._itemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItemRow,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (InventoryItemRow, $$InventoryItemsTableReferences),
      InventoryItemRow,
      PrefetchHooks Function({bool userId, bool itemId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ReminderSettingsTableTableManager get reminderSettings =>
      $$ReminderSettingsTableTableManager(_db, _db.reminderSettings);
  $$HydrationGoalsTableTableManager get hydrationGoals =>
      $$HydrationGoalsTableTableManager(_db, _db.hydrationGoals);
  $$WaterIntakesTableTableManager get waterIntakes =>
      $$WaterIntakesTableTableManager(_db, _db.waterIntakes);
  $$DailyProgressTableTableManager get dailyProgress =>
      $$DailyProgressTableTableManager(_db, _db.dailyProgress);
  $$GamificationProfilesTableTableManager get gamificationProfiles =>
      $$GamificationProfilesTableTableManager(_db, _db.gamificationProfiles);
  $$RewardTransactionsTableTableManager get rewardTransactions =>
      $$RewardTransactionsTableTableManager(_db, _db.rewardTransactions);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$UserAchievementsTableTableManager get userAchievements =>
      $$UserAchievementsTableTableManager(_db, _db.userAchievements);
  $$MissionsTableTableManager get missions =>
      $$MissionsTableTableManager(_db, _db.missions);
  $$UserMissionsTableTableManager get userMissions =>
      $$UserMissionsTableTableManager(_db, _db.userMissions);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$ShopItemsTableTableManager get shopItems =>
      $$ShopItemsTableTableManager(_db, _db.shopItems);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
}
