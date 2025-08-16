import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

class Budget {
  String name;
  int amount;
  int? periodDays = 0;

  Trip? trip;

  List<Expense>? expenses;

  String? tripId; // foreign key
  String? id;

  Budget({required this.name, required this.amount, this.periodDays, this.trip, this.expenses, this.tripId, this.id}){
    periodDays = periodDays ?? 0;
    for (Expense e in expenses?? []) {
      // print('${e.desc}: ${e.amount}, from $trip');
      e.budget = this;
    }
  }
}