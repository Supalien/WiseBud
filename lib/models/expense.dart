import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

class Expense {
  int amount;
  late String desc;
  late DateTime time;
  late String currency; // make it an enum instead of String

  Trip? trip;
  Budget? budget;

  String? id;
  String? tripId;
  String? budgetId;

  Expense({
    required this.amount,
    this.desc = "This expense lacks a description.",
    DateTime? time,
    this.currency = "USD",
    this.trip,
    this.budget,
    this.id,
    this.tripId,
    this.budgetId,
  }) {
    this.time = time ?? DateTime.now();
  }

  factory Expense.fromJson(Map<String, dynamic> m) {
    var e = Expense(
      amount: m['amount'],
      desc: m['desc'],
      time: m['time'],
      currency: m['currency']
    );
    if (m.containsKey('id')) e.id = m['id'];
    if (m.containsKey('tripId')) e.tripId = m['tripId'];
    if (m.containsKey('budgetId')) e.budgetId = m['budgetId'];
    return e;
  }

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'desc': desc,
    'time': time,
    'currency': currency,
    if (id != null) 'id': id,
    if (tripId != null) 'tripId': tripId,
    if (budgetId != null) 'budgetId': budgetId,
  };
}