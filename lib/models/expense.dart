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
    this.desc = "Add a description to this expense",
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
}
