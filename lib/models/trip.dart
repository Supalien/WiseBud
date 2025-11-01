import 'package:drift/drift.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/utils.dart';

class Trip {
  String name;
  List<String> destinations;
  DateTime startDate;
  DateTime endDate;
  String defaultCurrency;

  List<Budget> budgets;
  List<Expense> expenses; // only expenses that are not in a budget

  int? id;
  DateTime? createdAt;
  // String? userId;

  int get lengthDays => endDate.difference(startDate).inDays;
  // all expenses including budget expenses and expenses that are not in a budget
  List<Expense> get allExpenses => [
    ...expenses,
    ...budgets.expand((b) => b.expenses),
  ];
  // only budget expenses
  List<Expense> get budgetExpenses =>
      budgets.expand((b) => b.expenses).toList();

  Trip({
    required this.name,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    this.defaultCurrency = "USD",
    List<Budget>? budgets,
    List<Expense>? expenses,
    this.id,
    this.createdAt,
  }) : destinations = destinations ?? [],
       budgets = [],
       expenses = [],
       startDate = startDate ?? DateTime.now(),
       endDate = endDate ?? DateTime.now().add(Duration(days: 30)) {
    for (Budget b in budgets ?? []) {
      addBudget(b);
    }
    for (Expense e in expenses ?? []) {
      addExpense(e);
    }
  }

  Trip copyWith({
    String? name,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    String? defaultCurrency,
  }) {
    return Trip(
      name: name ?? this.name,
      destinations: destinations ?? this.destinations,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,

      budgets: budgets,
      expenses: expenses,

      id: id,
      createdAt: createdAt,
    );
  }

  double get totalBudget => budgets.fold(
    0,
    (sum, b) => (b.period == Period.non)
        ? sum + b.amount
        : sum + b.amount * lengthDays / b.periodDays,
  );

  double get totalExpenses => allExpenses.fold(0, (sum, e) => sum + e.amount);

  double get monthlyBudget => (budgets.where(
    (b) => b.periodDays > 0,
  )).fold(0, (sum, b) => sum + b.amount * currentMonthLength() / b.periodDays);

  double get monthlyExpenses => (budgetExpenses.where(
    (e) =>
        e.budget!.periodDays > 0 && isInThisMonth(e.time),
  )).fold(0, (sum, e) => sum + e.amount);

  void addExpense(Expense ex) {
    if (ex.budget != null) {
      expenses.add(ex);
    }
    ex.trip = this;
    ex.tripId = id;
  }

  void addBudget(Budget b) {
    budgets.add(b);
    b.trip = this;
    b.tripId = id;
  }

  factory Trip.fromItem(
    TripItem item, {
    List<Budget>? budgets,
    List<Expense>? expenses,
  }) {
    return Trip(
      id: item.id,
      createdAt: item.createdAt,

      name: item.name,
      destinations: item.destinations,
      startDate: item.startDate,
      endDate: item.endDate,
      defaultCurrency: item.defaultCurrency ?? "USD",

      budgets: budgets,
      expenses: expenses,
    );
  }

  TripItemsCompanion toCompanion() {
    return TripItemsCompanion.insert(
      id: Value.absentIfNull(id),
      createdAt: Value.absentIfNull(createdAt),

      name: name,
      destinations: destinations,
      startDate: startDate,
      endDate: endDate,
      defaultCurrency: Value.absentIfNull(defaultCurrency),
    );
  }

  @override
  String toString() => "Trip '$name'[${id ?? 0}]";

  // // Convert Supabase row → Trip
  // factory Trip.fromRow(Map<String, dynamic> map) {
  //   return Trip(
  //     id: map['id'] as String,
  //     userId: map['user_id'] as String,
  //     createdAt: DateTime.parse(map['created_at']),
  //     name: map['name'],
  //     destinations: List<String>.from(map['destinations'] ?? []),
  //     startDate: map['start_date'] != null
  //         ? DateTime.parse(map['start_date'])
  //         : null,
  //     endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
  //   );
  // }

  // factory Trip.fromJson(Map<String, dynamic> m) {
  //   var t = Trip(
  //     name: m['name'],
  //     destinations: List<String>.from(json.decode(m['destinations'])),
  //     startDate: DateTime.parse(m['startDate']),
  //     endDate: DateTime.parse(m['endDate']),
  //     defaultCurrency: m['defaultCurrency'],
  //     budgets: List<Budget>.from(json.decode(m['budgets']).map((b) => Budget.fromJson(b))),
  //     expenses: List<Expense>.from(json.decode(m['expenses']).map((e) => Expense.fromJson(e))),
  //   );
  //   if (m.containsKey('createdAt')) t.createdAt = DateTime.parse(m['createdAt']);
  //   if (m.containsKey('id')) t.id = m['id'];
  //   if (m.containsKey('userId')) t.userId = m['userId'];
  //   return t;
  // }

  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'destinations': json.encode(destinations),
  //   'startDate': startDate.toString(),
  //   'endDate': endDate.toString(),
  //   'defaultCurrency': defaultCurrency,
  //   'budgets': json.encode(budgets),
  //   'expenses': json.encode(expenses),
  //   if (createdAt != null) 'createdAt': createdAt,
  //   if (id != null) 'id': id,
  //   if (userId != null) 'userId': userId,
  // };
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
