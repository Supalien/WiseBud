import 'package:drift/drift.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/utils.dart';

class Budget {
  String name;
  String? desc;
  int amount;
  Period period;
  int? customPeriod;

  Trip? trip;

  List<Expense> expenses;

  int? id;
  DateTime? createdAt;
  int? tripId; // foreign key

  Budget({
    required this.name,
    this.desc,
    required this.amount,
    this.period = Period.non,
    this.customPeriod,

    this.trip,
    List<Expense>? expenses,
    this.id,
    this.createdAt,
    this.tripId,
  }) : expenses = expenses ?? [] {
    for (Expense e in this.expenses) {
      e.budget = this;
    }
  }

  Budget copyWith({
    String? name,
    int? amount,
    String? desc,
    Period? period,
    int? customPeriod,
    List<Expense>? expenses,
  }) {
    return Budget(name: name ?? this.name, amount: amount ?? this.amount);
  }

  int get periodDays => switch (period) {
    Period.daily => 1,
    Period.weekly => 7,
    Period.monthly => currentMonthLength(),
    Period.yearly => currentYearLength(),
    Period.custom => customPeriod ?? 0,
    _ => 0,
  };

  double get totalExpenses => expenses.fold(0, (sum, e) => sum + e.amount);

  void addExpense(Expense ex) {
    expenses.add(ex);
    ex.budget = this;
    ex.budgetId = id;
  }

  factory Budget.fromItem(
    BudgetItem item, {
    Trip? trip,
    List<Expense>? expenses,
  }) {
    return Budget(
      id: item.id,
      createdAt: item.createdAt,

      name: item.name,
      desc: item.desc,
      amount: item.amount,
      period: item.period,

      tripId: item.tripId,

      trip: trip,
      expenses: expenses,
    );
  }

  BudgetItemsCompanion toCompanion() {
    return BudgetItemsCompanion.insert(
      id: Value.absentIfNull(id),
      createdAt: Value.absentIfNull(createdAt),

      name: name,
      desc: Value.absentIfNull(desc),
      amount: amount,
      period: period,
      customPeriod: Value.absentIfNull(customPeriod),

      tripId: Value.absentIfNull(tripId ?? trip?.id),
    );
  }

  @override
  String toString() =>
      "Budget '$name'[${id ?? 0}] ${trip != null ? "of $trip" : ""} - $amount";

  // factory Budget.fromJson(Map<String, dynamic> m) {
  //   var b = Budget(
  //     name: m['name'],
  //     amount: m['amount'],
  //     periodDays: m['peroidDays'] ?? 0,
  //     expenses: List<Expense>.from(
  //       json.decode(m['expenses']).map((e) => Expense.fromJson(e)),
  //     ), // 1. decode m['expenses'] to List (of maps) 2. construct Expense from every map object of that list 3. turn this into list of Expenses
  //   );
  //   if (m.containsKey('desc')) b.desc = m['desc'];
  //   if (m.containsKey('id')) b.id = m['id'];
  //   if (m.containsKey('tripId')) b.tripId = m['tripId'];
  //   return b;
  // }

  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'amount': amount,
  //   'periodDays': periodDays,
  //   'expenses': json.encode(expenses),
  //   if (desc != null) 'budgetId': desc,
  //   if (id != null) 'id': id,
  //   if (tripId != null) 'tripId': tripId,
  // };
}

enum Period { non, daily, weekly, monthly, halfYearly, yearly, custom }
