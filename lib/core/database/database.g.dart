// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepDurationMinutesMeta =
      const VerificationMeta('sleepDurationMinutes');
  @override
  late final GeneratedColumn<int> sleepDurationMinutes = GeneratedColumn<int>(
      'sleep_duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _wakeUpTimeMeta =
      const VerificationMeta('wakeUpTime');
  @override
  late final GeneratedColumn<int> wakeUpTime = GeneratedColumn<int>(
      'wake_up_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, sleepDurationMinutes, wakeUpTime, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<Alarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('sleep_duration_minutes')) {
      context.handle(
          _sleepDurationMinutesMeta,
          sleepDurationMinutes.isAcceptableOrUnknown(
              data['sleep_duration_minutes']!, _sleepDurationMinutesMeta));
    }
    if (data.containsKey('wake_up_time')) {
      context.handle(
          _wakeUpTimeMeta,
          wakeUpTime.isAcceptableOrUnknown(
              data['wake_up_time']!, _wakeUpTimeMeta));
    } else if (isInserting) {
      context.missing(_wakeUpTimeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      sleepDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sleep_duration_minutes']),
      wakeUpTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wake_up_time'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class Alarm extends DataClass implements Insertable<Alarm> {
  final String id;
  final String type;
  final int? sleepDurationMinutes;
  final int wakeUpTime;
  final bool isActive;
  final int createdAt;
  const Alarm(
      {required this.id,
      required this.type,
      this.sleepDurationMinutes,
      required this.wakeUpTime,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || sleepDurationMinutes != null) {
      map['sleep_duration_minutes'] = Variable<int>(sleepDurationMinutes);
    }
    map['wake_up_time'] = Variable<int>(wakeUpTime);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      type: Value(type),
      sleepDurationMinutes: sleepDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepDurationMinutes),
      wakeUpTime: Value(wakeUpTime),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      sleepDurationMinutes:
          serializer.fromJson<int?>(json['sleepDurationMinutes']),
      wakeUpTime: serializer.fromJson<int>(json['wakeUpTime']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'sleepDurationMinutes': serializer.toJson<int?>(sleepDurationMinutes),
      'wakeUpTime': serializer.toJson<int>(wakeUpTime),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Alarm copyWith(
          {String? id,
          String? type,
          Value<int?> sleepDurationMinutes = const Value.absent(),
          int? wakeUpTime,
          bool? isActive,
          int? createdAt}) =>
      Alarm(
        id: id ?? this.id,
        type: type ?? this.type,
        sleepDurationMinutes: sleepDurationMinutes.present
            ? sleepDurationMinutes.value
            : this.sleepDurationMinutes,
        wakeUpTime: wakeUpTime ?? this.wakeUpTime,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  Alarm copyWithCompanion(AlarmsCompanion data) {
    return Alarm(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      sleepDurationMinutes: data.sleepDurationMinutes.present
          ? data.sleepDurationMinutes.value
          : this.sleepDurationMinutes,
      wakeUpTime:
          data.wakeUpTime.present ? data.wakeUpTime.value : this.wakeUpTime,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sleepDurationMinutes: $sleepDurationMinutes, ')
          ..write('wakeUpTime: $wakeUpTime, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, sleepDurationMinutes, wakeUpTime, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.type == this.type &&
          other.sleepDurationMinutes == this.sleepDurationMinutes &&
          other.wakeUpTime == this.wakeUpTime &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<String> id;
  final Value<String> type;
  final Value<int?> sleepDurationMinutes;
  final Value<int> wakeUpTime;
  final Value<bool> isActive;
  final Value<int> createdAt;
  final Value<int> rowid;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.sleepDurationMinutes = const Value.absent(),
    this.wakeUpTime = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlarmsCompanion.insert({
    required String id,
    required String type,
    this.sleepDurationMinutes = const Value.absent(),
    required int wakeUpTime,
    this.isActive = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        wakeUpTime = Value(wakeUpTime),
        createdAt = Value(createdAt);
  static Insertable<Alarm> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? sleepDurationMinutes,
    Expression<int>? wakeUpTime,
    Expression<bool>? isActive,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (sleepDurationMinutes != null)
        'sleep_duration_minutes': sleepDurationMinutes,
      if (wakeUpTime != null) 'wake_up_time': wakeUpTime,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlarmsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<int?>? sleepDurationMinutes,
      Value<int>? wakeUpTime,
      Value<bool>? isActive,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      sleepDurationMinutes: sleepDurationMinutes ?? this.sleepDurationMinutes,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      isActive: isActive ?? this.isActive,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (sleepDurationMinutes.present) {
      map['sleep_duration_minutes'] = Variable<int>(sleepDurationMinutes.value);
    }
    if (wakeUpTime.present) {
      map['wake_up_time'] = Variable<int>(wakeUpTime.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('sleepDurationMinutes: $sleepDurationMinutes, ')
          ..write('wakeUpTime: $wakeUpTime, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepRecordsTable extends SleepRecords
    with TableInfo<$SleepRecordsTable, SleepRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sleepTimeMeta =
      const VerificationMeta('sleepTime');
  @override
  late final GeneratedColumn<int> sleepTime = GeneratedColumn<int>(
      'sleep_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wakeTimeMeta =
      const VerificationMeta('wakeTime');
  @override
  late final GeneratedColumn<int> wakeTime = GeneratedColumn<int>(
      'wake_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<int> qualityScore = GeneratedColumn<int>(
      'quality_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sleepTime, wakeTime, durationMinutes, qualityScore, tags, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_records';
  @override
  VerificationContext validateIntegrity(Insertable<SleepRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sleep_time')) {
      context.handle(_sleepTimeMeta,
          sleepTime.isAcceptableOrUnknown(data['sleep_time']!, _sleepTimeMeta));
    } else if (isInserting) {
      context.missing(_sleepTimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(_wakeTimeMeta,
          wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta));
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    } else if (isInserting) {
      context.missing(_qualityScoreMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sleepTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_time'])!,
      wakeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wake_time'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quality_score'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SleepRecordsTable createAlias(String alias) {
    return $SleepRecordsTable(attachedDatabase, alias);
  }
}

class SleepRecord extends DataClass implements Insertable<SleepRecord> {
  final String id;
  final int sleepTime;
  final int wakeTime;
  final int durationMinutes;
  final int qualityScore;
  final String tags;
  final int createdAt;
  const SleepRecord(
      {required this.id,
      required this.sleepTime,
      required this.wakeTime,
      required this.durationMinutes,
      required this.qualityScore,
      required this.tags,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sleep_time'] = Variable<int>(sleepTime);
    map['wake_time'] = Variable<int>(wakeTime);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['quality_score'] = Variable<int>(qualityScore);
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SleepRecordsCompanion toCompanion(bool nullToAbsent) {
    return SleepRecordsCompanion(
      id: Value(id),
      sleepTime: Value(sleepTime),
      wakeTime: Value(wakeTime),
      durationMinutes: Value(durationMinutes),
      qualityScore: Value(qualityScore),
      tags: Value(tags),
      createdAt: Value(createdAt),
    );
  }

  factory SleepRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepRecord(
      id: serializer.fromJson<String>(json['id']),
      sleepTime: serializer.fromJson<int>(json['sleepTime']),
      wakeTime: serializer.fromJson<int>(json['wakeTime']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      qualityScore: serializer.fromJson<int>(json['qualityScore']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sleepTime': serializer.toJson<int>(sleepTime),
      'wakeTime': serializer.toJson<int>(wakeTime),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'qualityScore': serializer.toJson<int>(qualityScore),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SleepRecord copyWith(
          {String? id,
          int? sleepTime,
          int? wakeTime,
          int? durationMinutes,
          int? qualityScore,
          String? tags,
          int? createdAt}) =>
      SleepRecord(
        id: id ?? this.id,
        sleepTime: sleepTime ?? this.sleepTime,
        wakeTime: wakeTime ?? this.wakeTime,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        qualityScore: qualityScore ?? this.qualityScore,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
      );
  SleepRecord copyWithCompanion(SleepRecordsCompanion data) {
    return SleepRecord(
      id: data.id.present ? data.id.value : this.id,
      sleepTime: data.sleepTime.present ? data.sleepTime.value : this.sleepTime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecord(')
          ..write('id: $id, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, sleepTime, wakeTime, durationMinutes, qualityScore, tags, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepRecord &&
          other.id == this.id &&
          other.sleepTime == this.sleepTime &&
          other.wakeTime == this.wakeTime &&
          other.durationMinutes == this.durationMinutes &&
          other.qualityScore == this.qualityScore &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt);
}

class SleepRecordsCompanion extends UpdateCompanion<SleepRecord> {
  final Value<String> id;
  final Value<int> sleepTime;
  final Value<int> wakeTime;
  final Value<int> durationMinutes;
  final Value<int> qualityScore;
  final Value<String> tags;
  final Value<int> createdAt;
  final Value<int> rowid;
  const SleepRecordsCompanion({
    this.id = const Value.absent(),
    this.sleepTime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepRecordsCompanion.insert({
    required String id,
    required int sleepTime,
    required int wakeTime,
    required int durationMinutes,
    required int qualityScore,
    this.tags = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sleepTime = Value(sleepTime),
        wakeTime = Value(wakeTime),
        durationMinutes = Value(durationMinutes),
        qualityScore = Value(qualityScore),
        createdAt = Value(createdAt);
  static Insertable<SleepRecord> custom({
    Expression<String>? id,
    Expression<int>? sleepTime,
    Expression<int>? wakeTime,
    Expression<int>? durationMinutes,
    Expression<int>? qualityScore,
    Expression<String>? tags,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sleepTime != null) 'sleep_time': sleepTime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepRecordsCompanion copyWith(
      {Value<String>? id,
      Value<int>? sleepTime,
      Value<int>? wakeTime,
      Value<int>? durationMinutes,
      Value<int>? qualityScore,
      Value<String>? tags,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return SleepRecordsCompanion(
      id: id ?? this.id,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeTime: wakeTime ?? this.wakeTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      qualityScore: qualityScore ?? this.qualityScore,
      tags: tags ?? this.tags,
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
    if (sleepTime.present) {
      map['sleep_time'] = Variable<int>(sleepTime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<int>(wakeTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<int>(qualityScore.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepRecordsCompanion(')
          ..write('id: $id, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idealSleepDurationMinutesMeta =
      const VerificationMeta('idealSleepDurationMinutes');
  @override
  late final GeneratedColumn<int> idealSleepDurationMinutes =
      GeneratedColumn<int>('ideal_sleep_duration_minutes', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(480));
  static const VerificationMeta _preferredBedtimeMeta =
      const VerificationMeta('preferredBedtime');
  @override
  late final GeneratedColumn<String> preferredBedtime = GeneratedColumn<String>(
      'preferred_bedtime', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('22:00'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        idealSleepDurationMinutes,
        preferredBedtime,
        notificationsEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ideal_sleep_duration_minutes')) {
      context.handle(
          _idealSleepDurationMinutesMeta,
          idealSleepDurationMinutes.isAcceptableOrUnknown(
              data['ideal_sleep_duration_minutes']!,
              _idealSleepDurationMinutesMeta));
    }
    if (data.containsKey('preferred_bedtime')) {
      context.handle(
          _preferredBedtimeMeta,
          preferredBedtime.isAcceptableOrUnknown(
              data['preferred_bedtime']!, _preferredBedtimeMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      idealSleepDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}ideal_sleep_duration_minutes'])!,
      preferredBedtime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}preferred_bedtime'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String name;
  final int idealSleepDurationMinutes;
  final String preferredBedtime;
  final bool notificationsEnabled;
  const UserProfile(
      {required this.id,
      required this.name,
      required this.idealSleepDurationMinutes,
      required this.preferredBedtime,
      required this.notificationsEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['ideal_sleep_duration_minutes'] =
        Variable<int>(idealSleepDurationMinutes);
    map['preferred_bedtime'] = Variable<String>(preferredBedtime);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      idealSleepDurationMinutes: Value(idealSleepDurationMinutes),
      preferredBedtime: Value(preferredBedtime),
      notificationsEnabled: Value(notificationsEnabled),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      idealSleepDurationMinutes:
          serializer.fromJson<int>(json['idealSleepDurationMinutes']),
      preferredBedtime: serializer.fromJson<String>(json['preferredBedtime']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'idealSleepDurationMinutes':
          serializer.toJson<int>(idealSleepDurationMinutes),
      'preferredBedtime': serializer.toJson<String>(preferredBedtime),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
    };
  }

  UserProfile copyWith(
          {String? id,
          String? name,
          int? idealSleepDurationMinutes,
          String? preferredBedtime,
          bool? notificationsEnabled}) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        idealSleepDurationMinutes:
            idealSleepDurationMinutes ?? this.idealSleepDurationMinutes,
        preferredBedtime: preferredBedtime ?? this.preferredBedtime,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      idealSleepDurationMinutes: data.idealSleepDurationMinutes.present
          ? data.idealSleepDurationMinutes.value
          : this.idealSleepDurationMinutes,
      preferredBedtime: data.preferredBedtime.present
          ? data.preferredBedtime.value
          : this.preferredBedtime,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idealSleepDurationMinutes: $idealSleepDurationMinutes, ')
          ..write('preferredBedtime: $preferredBedtime, ')
          ..write('notificationsEnabled: $notificationsEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, idealSleepDurationMinutes,
      preferredBedtime, notificationsEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.idealSleepDurationMinutes == this.idealSleepDurationMinutes &&
          other.preferredBedtime == this.preferredBedtime &&
          other.notificationsEnabled == this.notificationsEnabled);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> idealSleepDurationMinutes;
  final Value<String> preferredBedtime;
  final Value<bool> notificationsEnabled;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.idealSleepDurationMinutes = const Value.absent(),
    this.preferredBedtime = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String name,
    this.idealSleepDurationMinutes = const Value.absent(),
    this.preferredBedtime = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? idealSleepDurationMinutes,
    Expression<String>? preferredBedtime,
    Expression<bool>? notificationsEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (idealSleepDurationMinutes != null)
        'ideal_sleep_duration_minutes': idealSleepDurationMinutes,
      if (preferredBedtime != null) 'preferred_bedtime': preferredBedtime,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? idealSleepDurationMinutes,
      Value<String>? preferredBedtime,
      Value<bool>? notificationsEnabled,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      idealSleepDurationMinutes:
          idealSleepDurationMinutes ?? this.idealSleepDurationMinutes,
      preferredBedtime: preferredBedtime ?? this.preferredBedtime,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
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
    if (idealSleepDurationMinutes.present) {
      map['ideal_sleep_duration_minutes'] =
          Variable<int>(idealSleepDurationMinutes.value);
    }
    if (preferredBedtime.present) {
      map['preferred_bedtime'] = Variable<String>(preferredBedtime.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idealSleepDurationMinutes: $idealSleepDurationMinutes, ')
          ..write('preferredBedtime: $preferredBedtime, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $SleepRecordsTable sleepRecords = $SleepRecordsTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, sleepRecords, userProfiles];
}

typedef $$AlarmsTableCreateCompanionBuilder = AlarmsCompanion Function({
  required String id,
  required String type,
  Value<int?> sleepDurationMinutes,
  required int wakeUpTime,
  Value<bool> isActive,
  required int createdAt,
  Value<int> rowid,
});
typedef $$AlarmsTableUpdateCompanionBuilder = AlarmsCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<int?> sleepDurationMinutes,
  Value<int> wakeUpTime,
  Value<bool> isActive,
  Value<int> createdAt,
  Value<int> rowid,
});

class $$AlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepDurationMinutes => $composableBuilder(
      column: $table.sleepDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wakeUpTime => $composableBuilder(
      column: $table.wakeUpTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepDurationMinutes => $composableBuilder(
      column: $table.sleepDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wakeUpTime => $composableBuilder(
      column: $table.wakeUpTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get sleepDurationMinutes => $composableBuilder(
      column: $table.sleepDurationMinutes, builder: (column) => column);

  GeneratedColumn<int> get wakeUpTime => $composableBuilder(
      column: $table.wakeUpTime, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AlarmsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()> {
  $$AlarmsTableTableManager(_$AppDatabase db, $AlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> sleepDurationMinutes = const Value.absent(),
            Value<int> wakeUpTime = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlarmsCompanion(
            id: id,
            type: type,
            sleepDurationMinutes: sleepDurationMinutes,
            wakeUpTime: wakeUpTime,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            Value<int?> sleepDurationMinutes = const Value.absent(),
            required int wakeUpTime,
            Value<bool> isActive = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlarmsCompanion.insert(
            id: id,
            type: type,
            sleepDurationMinutes: sleepDurationMinutes,
            wakeUpTime: wakeUpTime,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()>;
typedef $$SleepRecordsTableCreateCompanionBuilder = SleepRecordsCompanion
    Function({
  required String id,
  required int sleepTime,
  required int wakeTime,
  required int durationMinutes,
  required int qualityScore,
  Value<String> tags,
  required int createdAt,
  Value<int> rowid,
});
typedef $$SleepRecordsTableUpdateCompanionBuilder = SleepRecordsCompanion
    Function({
  Value<String> id,
  Value<int> sleepTime,
  Value<int> wakeTime,
  Value<int> durationMinutes,
  Value<int> qualityScore,
  Value<String> tags,
  Value<int> createdAt,
  Value<int> rowid,
});

class $$SleepRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SleepRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SleepRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepRecordsTable> {
  $$SleepRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sleepTime =>
      $composableBuilder(column: $table.sleepTime, builder: (column) => column);

  GeneratedColumn<int> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SleepRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SleepRecordsTable,
    SleepRecord,
    $$SleepRecordsTableFilterComposer,
    $$SleepRecordsTableOrderingComposer,
    $$SleepRecordsTableAnnotationComposer,
    $$SleepRecordsTableCreateCompanionBuilder,
    $$SleepRecordsTableUpdateCompanionBuilder,
    (
      SleepRecord,
      BaseReferences<_$AppDatabase, $SleepRecordsTable, SleepRecord>
    ),
    SleepRecord,
    PrefetchHooks Function()> {
  $$SleepRecordsTableTableManager(_$AppDatabase db, $SleepRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> sleepTime = const Value.absent(),
            Value<int> wakeTime = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int> qualityScore = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepRecordsCompanion(
            id: id,
            sleepTime: sleepTime,
            wakeTime: wakeTime,
            durationMinutes: durationMinutes,
            qualityScore: qualityScore,
            tags: tags,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int sleepTime,
            required int wakeTime,
            required int durationMinutes,
            required int qualityScore,
            Value<String> tags = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepRecordsCompanion.insert(
            id: id,
            sleepTime: sleepTime,
            wakeTime: wakeTime,
            durationMinutes: durationMinutes,
            qualityScore: qualityScore,
            tags: tags,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SleepRecordsTable,
    SleepRecord,
    $$SleepRecordsTableFilterComposer,
    $$SleepRecordsTableOrderingComposer,
    $$SleepRecordsTableAnnotationComposer,
    $$SleepRecordsTableCreateCompanionBuilder,
    $$SleepRecordsTableUpdateCompanionBuilder,
    (
      SleepRecord,
      BaseReferences<_$AppDatabase, $SleepRecordsTable, SleepRecord>
    ),
    SleepRecord,
    PrefetchHooks Function()>;
typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String id,
  required String name,
  Value<int> idealSleepDurationMinutes,
  Value<String> preferredBedtime,
  Value<bool> notificationsEnabled,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> idealSleepDurationMinutes,
  Value<String> preferredBedtime,
  Value<bool> notificationsEnabled,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get idealSleepDurationMinutes => $composableBuilder(
      column: $table.idealSleepDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferredBedtime => $composableBuilder(
      column: $table.preferredBedtime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get idealSleepDurationMinutes => $composableBuilder(
      column: $table.idealSleepDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferredBedtime => $composableBuilder(
      column: $table.preferredBedtime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
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

  GeneratedColumn<int> get idealSleepDurationMinutes => $composableBuilder(
      column: $table.idealSleepDurationMinutes, builder: (column) => column);

  GeneratedColumn<String> get preferredBedtime => $composableBuilder(
      column: $table.preferredBedtime, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> idealSleepDurationMinutes = const Value.absent(),
            Value<String> preferredBedtime = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            idealSleepDurationMinutes: idealSleepDurationMinutes,
            preferredBedtime: preferredBedtime,
            notificationsEnabled: notificationsEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> idealSleepDurationMinutes = const Value.absent(),
            Value<String> preferredBedtime = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            idealSleepDurationMinutes: idealSleepDurationMinutes,
            preferredBedtime: preferredBedtime,
            notificationsEnabled: notificationsEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$SleepRecordsTableTableManager get sleepRecords =>
      $$SleepRecordsTableTableManager(_db, _db.sleepRecords);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
}
