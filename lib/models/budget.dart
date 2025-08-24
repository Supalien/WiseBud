import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

class Budget extends ChangeNotifier {
  String name;
  String? desc;
  int amount;
  late int periodDays; // TODO: need to figure out how to proccess monthly budgets when months have dynamic lengths. (maybe average of months length in the period of the trip?)

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
      e.budget = this;
    }
  }
  
  double get totalExpenses => expenses.fold(0, (sum, e) => sum + e.amount);
  
  factory Budget.fromJson(Map<String, dynamic> m) {
    var b = Budget(
      name: m['name'],
      amount: m['amount'],
      periodDays: m['peroidDays'] ?? 0,
      expenses: List<Expense>.from(json.decode(m['expenses']).map((e) => Expense.fromJson(e))), // 1. decode m['expenses'] to List (of maps) 2. construct Expense from every map object of that list 3. turn this into list of Expenses
    );
    if (m.containsKey('desc')) b.desc = m['desc'];
    if (m.containsKey('id')) b.id = m['id'];
    if (m.containsKey('tripId')) b.tripId = m['tripId'];
    return b;
  }

  void addExpense(Expense ex){
    expenses.add(ex);
    notifyListeners();
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
