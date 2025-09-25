import 'package:drift/drift.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

class Budget {
  String name;
  String? desc;
  int amount;
  int
  periodDays; // TODO: need to figure out how to proccess monthly budgets when months have dynamic lengths. (maybe average of months length in the period of the trip?)
              // Issue URL: https://github.com/Supalien/WiseBud/issues/28

  Trip? trip;

  List<Expense> expenses;

  int? id;
  DateTime? createdAt;
  int? tripId; // foreign key

  Budget({
    required this.name,
    this.desc,
    required this.amount,
    this.periodDays = 0,

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

  double get totalExpenses => expenses.fold(0, (sum, e) => sum + e.amount);

  void addExpense(Expense ex) {
    expenses.add(ex);
    ex.budget = this;
    ex.budgetId = id;
  }

    factory Budget.fromItem(BudgetItem item, {Trip? trip, List<Expense>? expenses}) {
    return Budget(
      id: item.id,
      createdAt: item.createdAt,

      name: item.name,
      desc: item.desc,
      amount: item.amount,
      periodDays: item.periodDays,

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
      periodDays: periodDays,

      tripId: Value.absentIfNull(tripId ?? trip?.id),
    );
  }

  @override
  String toString() => "Budget '$name'[${id ?? 0}] ${trip!=null ? "of $trip" : ""} - $amount";
  
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
