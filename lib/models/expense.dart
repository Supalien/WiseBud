import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

class Expense {
  int amount;
  String? desc;
  DateTime? time;
  String? currency;

  Trip? trip;
  Budget? budget;
  
  String? id;
  String? tripId;
  String? budgetId;

  Expense({required this.amount, this.desc, this.time, this.currency, this.trip, this.budget, this.id, this.tripId, this.budgetId}){
    time = time ?? DateTime.now();
  }
}