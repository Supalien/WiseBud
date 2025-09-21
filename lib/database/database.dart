import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

part 'database.g.dart';

@DriftDatabase(tables: [Expenses])
class AppDatabase extends _$AppDatabase {
    AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());
    static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}


class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  RealColumn get amount => real()();
  TextColumn get desc => text()();
  DateTimeColumn get time => dateTime()();
  TextColumn get currency => text()();

  IntColumn get trip => integer().nullable().references(Trips, #id)();
  IntColumn get budget => integer().nullable().references(Budgets, #id)();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  TextColumn get name => text()();
  TextColumn get desc => text().nullable()();
  IntColumn get amount => integer()();
  IntColumn get periodDays => integer()();

  IntColumn get trip => integer().nullable().references(Trips, #id)();
}

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  TextColumn get name => text()();
  TextColumn get destinations => text().map(StringListTypeConverter())();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get defaultCurrency => text()();
}


class StringListTypeConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> fromSql(String fromDb) {
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}