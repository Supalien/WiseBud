import 'package:flutter/material.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/user.dart';
import 'package:wisebud/utils.dart';

class Trip extends ChangeNotifier{
  String name;
  DateTime? createdAt;
  List<String>? destinations;
  DateTime? startDate;
  DateTime? endDate;
  String? defaultCurrency = "USD";

  User? user;

  List<Budget>? budgets;
  List<Expense>? expenses;
  
  String? id;
  String? userId;

  int? lengthDays;

  Trip({required this.name, this.createdAt, this.destinations, this.startDate, this.endDate, this.defaultCurrency, this.user, this.budgets, this.expenses, this.id, this.userId}){
    destinations = destinations ?? [];
    defaultCurrency = defaultCurrency ?? "USD";
    budgets = budgets ?? [];
    expenses = expenses ?? [];
    startDate = startDate ?? DateTime.now();
    endDate = endDate ?? DateTime.now().add(Duration(days: 1));
    lengthDays = endDate!.difference(startDate!).inDays;
    for (Budget b in budgets ?? []) {
      b.trip = this;
      expenses?.addAll(b.expenses ?? []);
    }
    for (Expense e in expenses ?? []) {
      e.trip = this;
    }
  }

  double get totalBudget => 
    (budgets ?? []).fold(0.0, (sum, b) => (b.periodDays == null || b.periodDays == 0)? sum + b.amount : sum + b.amount*lengthDays! / b.periodDays!);
  
  double get totalExpenses =>
    (expenses ?? []).fold(0, (sum, e) => sum + e.amount);

  double get monthlyBudget =>
    (budgets?.where((b) => b.periodDays! > 0) ?? []).fold(0, (sum, b) => sum + b.amount*30 / b.periodDays!);

  double get monthlyExpenses =>
    (expenses?.where((e) => e.budget!.periodDays! > 0 && isInThisMonth(e.time!))?? []).fold(0, (sum, e) => sum + e.amount);


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

  //
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