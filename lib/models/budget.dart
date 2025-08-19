import 'dart:convert';

import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

class Budget {
  String name;
  String? desc;
  int amount;
  late int periodDays;

  late Trip trip;

  late List<Expense> expenses;

  String? tripId; // foreign key
  String? id;

  Budget({
    required this.name,
    this.desc,
    required this.amount,
    this.periodDays = 0,
    List<Expense>? expenses,
    this.tripId,
    this.id,
  }) {
    this.expenses = expenses ?? [];
    for (Expense e in this.expenses) {
      // print('${e.desc}: ${e.amount}, from $trip');
      e.budget = this;
    }
  }
  factory Budget.fromJson(Map<String, dynamic> m) {
    var e = Budget(
      name: m['name'],
      amount: m['amount'],
      periodDays: m['peroidDays'] ?? 0,
      expenses: List<Expense>.from(json.decode(m['expenses']).map((e) => Expense.fromJson(e))), // 1. decode m['expenses'] to List (of maps) 2. construct Expense from every map object of that list 3. turn this into list of Expenses
    );
    if (m.containsKey('desc')) e.desc = m['desc'];
    if (m.containsKey('id')) e.id = m['id'];
    if (m.containsKey('tripId')) e.tripId = m['tripId'];
    return e;
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'amount': amount,
    'periodDays': periodDays,
    'expenses': json.encode(expenses),
    if (desc != null) 'budgetId': desc,
    if (id != null) 'id': id,
    if (tripId != null) 'tripId': tripId,
  };
}
