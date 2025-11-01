import 'package:drift/drift.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

class Expense {
  double amount;
  String desc;
  late DateTime time;
  String currency; // make it an enum instead of String

  Trip? trip;
  Budget? budget;

  int? id;
  DateTime? createdAt;

  int? tripId;
  int? budgetId;

  Expense({
    required this.amount,
    this.desc = "This expense lacks a description.",
    DateTime? time,
    this.currency = "USD",
    this.trip,
    this.budget,
    this.id,
    this.createdAt,
    this.tripId,
    this.budgetId,
  }) {
    this.time = time ?? DateTime.now();
  }

  Expense copyWith({
    double? amount,
    String? desc,
    DateTime? time,
    String? currency,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      desc: desc ?? this.desc,
      time: time ?? this.time,
      currency: currency ?? this.currency,

      trip: trip,
      budget: budget,
      id: id,
      createdAt: createdAt,
      tripId: tripId,
      budgetId: budgetId,
    );
  }

  factory Expense.fromItem(ExpenseItem item, {Trip? trip, Budget? budget}) {
    return Expense(
      id: item.id,
      createdAt: item.createdAt,

      amount: item.amount,
      desc: item.desc,
      time: item.time,
      currency: item.currency,

      tripId: item.tripId,
      budgetId: item.budgetId,

      trip: trip,
      budget: budget,
    );
  }

  ExpenseItemsCompanion toCompanion() {
    return ExpenseItemsCompanion.insert(
      id: Value.absentIfNull(id),
      createdAt: Value.absentIfNull(createdAt),

      amount: amount,
      desc: desc,
      time: time,
      currency: currency,

      tripId: Value.absentIfNull(tripId ?? trip?.id),
      budgetId: Value.absentIfNull(budgetId ?? budget?.id),
    );
  }

  @override
  String toString() =>
      "Expense $amount $currency ${id != null ? "id=$id" : ""}";

  // factory Expense.fromJson(Map<String, dynamic> m) {
  //   var e = Expense(
  //     amount: m['amount'],
  //     desc: m['desc'],
  //     time: DateTime.parse(m['time']),
  //     currency: m['currency']
  //   );
  //   if (m.containsKey('id')) e.id = m['id'];
  //   if (m.containsKey('tripId')) e.tripId = m['tripId'];
  //   if (m.containsKey('budgetId')) e.budgetId = m['budgetId'];
  //   return e;
  // }

  // Map<String, dynamic> toJson() => {
  //   'amount': amount,
  //   'desc': desc,
  //   'time': time.toString(),
  //   'currency': currency,
  //   if (id != null) 'id': id,
  //   if (tripId != null) 'tripId': tripId,
  //   if (budgetId != null) 'budgetId': budgetId,
  // };
}
