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
}
