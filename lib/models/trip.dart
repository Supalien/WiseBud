import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/user.dart';
import 'package:wisebud/utils.dart';

class Trip extends ChangeNotifier {
  String name;
  DateTime? createdAt;
  late List<String> destinations;
  late DateTime startDate;
  late DateTime endDate;
  late String defaultCurrency;

  User? user;

  late List<Budget> budgets;
  late List<Expense> expenses;

  String? id;
  String? userId;

  late int lengthDays;

  Trip({
    required this.name,
    this.createdAt,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    this.defaultCurrency = "USD",
    this.user,
    List<Budget>? budgets,
    List<Expense>? expenses,
    this.id,
    this.userId,
  }) {
    this.destinations = destinations ?? [];
    this.budgets = budgets ?? [];
    this.expenses = expenses ?? [];
    this.startDate = startDate ?? DateTime.now();
    this.endDate = endDate ?? DateTime.now().add(Duration(days: 30));
    lengthDays = this.endDate.difference(this.startDate).inDays;
    for (Budget b in this.budgets) {
      b.trip = this;
      this.expenses.addAll(b.expenses);
    }
    for (Expense e in this.expenses) {
      e.trip = this;
    }
  }

  double get totalBudget => budgets.fold(
    0.0,
    (sum, b) => (b.periodDays == 0)
        ? sum + b.amount
        : sum + b.amount * lengthDays / b.periodDays,
  );

  double get totalExpenses => expenses.fold(0, (sum, e) => sum + e.amount);

  double get monthlyBudget => (budgets.where(
    (b) => b.periodDays > 0,
  )).fold(0, (sum, b) => sum + b.amount * 30 / b.periodDays);

  double get monthlyExpenses => (expenses.where(
    (e) =>
        e.budget != null && e.budget!.periodDays > 0 && isInThisMonth(e.time),
  )).fold(0, (sum, e) => sum + e.amount);

  // Convert Supabase row → Trip
  factory Trip.fromRow(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
      destinations: List<String>.from(map['destinations'] ?? []),
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date'])
          : null,
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> m) {
    var t = Trip(
      name: m['name'],
      destinations: List<String>.from(json.decode(m['destinations'])),
      startDate: DateTime.parse(m['startDate']),
      endDate: DateTime.parse(m['endDate']),
      defaultCurrency: m['defaultCurrency'],
      budgets: List<Budget>.from(json.decode(m['budgets']).map((b) => Budget.fromJson(b))),
      expenses: List<Expense>.from(json.decode(m['expenses']).map((e) => Expense.fromJson(e))),
    );
    if (m.containsKey('createdAt')) t.createdAt = DateTime.parse(m['createdAt']);
    if (m.containsKey('id')) t.id = m['id'];
    if (m.containsKey('userId')) t.userId = m['userId'];
    return t;
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'destinations': json.encode(destinations),
    'startDate': startDate.toString(),
    'endDate': endDate.toString(),
    'defaultCurrency': defaultCurrency,
    'budgets': json.encode(budgets),
    'expenses': json.encode(expenses),
    if (createdAt != null) 'createdAt': createdAt,
    if (id != null) 'id': id,
    if (userId != null) 'userId': userId,
  };

  void addBudget(Budget b) {
    budgets.add(b);
    notifyListeners();
  }

  void addExpense(Expense ex) {
    expenses.add(ex);
    notifyListeners();
  }
}

/**
final response = await supabase
    .from('trips')
    .select()
    .eq('user_id', supabase.auth.currentUser!.id);

if (response is List) {
  final trips = response.map((row) => Trip.fromRow(row)).toList();
  // Now you have a typed list of Trip objects
}

 */
