import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

/// Alarms table for storing sleep alarms
class Alarms extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'duration' or 'fixed_time'
  IntColumn get sleepDurationMinutes => integer().nullable()();
  IntColumn get wakeUpTime => integer()(); // Unix timestamp
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sleep records table for tracking sleep sessions
class SleepRecords extends Table {
  TextColumn get id => text()();
  IntColumn get sleepTime => integer()();
  IntColumn get wakeTime => integer()();
  IntColumn get durationMinutes => integer()();
  IntColumn get qualityScore => integer()(); // 1-100
  TextColumn get tags => text().withDefault(const Constant('[]'))(); // JSON array
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// User profile table
class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get idealSleepDurationMinutes => integer().withDefault(const Constant(480))(); // 8 hours
  TextColumn get preferredBedtime => text().withDefault(const Constant('22:00'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Alarms, SleepRecords, UserProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'sleep_tracker.db'));
      return NativeDatabase(file);
    });
  }
}
