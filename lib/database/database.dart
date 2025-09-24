import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'dart:convert';

import 'package:wisebud/models/trip.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ExpenseItems, BudgetItems, TripItems])
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

  Future<Expense> loadExpenseById(int id) async {
    return Expense.fromItem(await managers.expenseItems.filter((f) => f.id(id)).getSingle());
  }

  Future<Budget> loadBudgetById(int id) async {
    final budgetItem = await managers.budgetItems.filter((f) => f.id(id)).getSingle(); // get budget item by id
    Budget b = Budget.fromItem(budgetItem); // convert item to model
    final budgetExpenseItems = await managers.expenseItems.filter((f) => f.budgetId.id(id)).get(); // get all expenses that reference this budget
    // add expenses to Budget
    // Issue URL: https://github.com/Supalien/WiseBud/issues/17
    for (ExpenseItem item in budgetExpenseItems) {
      b.addExpense(Expense.fromItem(item));
    }
    return b;
  }

  Future<Trip> loadTripById(int id) async {
    final tripItem = await managers.tripItems.filter((f) => f.id(id)).getSingle(); // get trip item by id
    final tripBudgetItems = await managers.budgetItems.filter((f) => f.tripId.id(id)).get(); // get all budgets that reference this trip
    final tripExpenseItems = await managers.expenseItems.filter((f) => f.tripId.id(id)).get(); // get all expenses that reference this trip
    
    Trip t = Trip.fromItem(tripItem); // convert to model
    // load every budget of trip and add it to trip
    // Issue URL: https://github.com/Supalien/WiseBud/issues/16
    for (BudgetItem budgetItem in tripBudgetItems) {
      Budget b = Budget.fromItem(budgetItem);
      final budgetExpenseItems = await managers.expenseItems.filter((f) => f.budgetId.id(id)).get(); // all expenses of budget
      // add expensed to Budget
      // Issue URL: https://github.com/Supalien/WiseBud/issues/15
      for (ExpenseItem expenseItem in budgetExpenseItems) {
        b.addExpense(Expense.fromItem(expenseItem));
      }
      t.addBudget(b);
    }
    // add all expenses
    // Issue URL: https://github.com/Supalien/WiseBud/issues/14
    for (ExpenseItem expenseItem in tripExpenseItems) {
      t.addExpense(Expense.fromItem(expenseItem));
    }
    return t;
  }
}


class ExpenseItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  RealColumn get amount => real()();
  TextColumn get desc => text()();
  DateTimeColumn get time => dateTime()();
  TextColumn get currency => text()();

  IntColumn get tripId => integer().nullable().references(TripItems, #id)();
  IntColumn get budgetId => integer().nullable().references(BudgetItems, #id)();
}

class BudgetItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  TextColumn get name => text()();
  TextColumn get desc => text().nullable()();
  IntColumn get amount => integer()();
  IntColumn get periodDays => integer()();

  IntColumn get tripId => integer().nullable().references(TripItems, #id)();
}

class TripItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDate)();
  
  TextColumn get name => text()();
  TextColumn get destinations => text().map(StringListTypeConverter())();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get defaultCurrency => text().nullable()();
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