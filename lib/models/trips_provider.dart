import 'package:flutter/widgets.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

class TripsProvider with ChangeNotifier {
  AppDatabase db;
  final Map<int, Trip> _trips = {}; // map id to trip
  int _currentTripId = -1;
  bool isLoading = true;

  Map<int, Trip> get trips => _trips;
  Trip? get trip => _trips[_currentTripId];

  TripsProvider(this.db, {int? currentTripId}) {
    if (currentTripId != null &&
        currentTripId >= 0 &&
        _trips.containsKey(currentTripId)) {
      _currentTripId = currentTripId;
    }
    loadAll();
  }

  Future<Trip> loadTrip(int id) async {
    Trip t = await db.loadTripById(id);
    _trips[id] = t;
    return t;
  }

  void loadAll() async {
    _trips.clear();
    for (var t in await db.select(db.tripItems).get()) {
      // if current trip id not yet set, set it to the first trip in db
      _currentTripId = _currentTripId == -1 ? t.id : _currentTripId;
      if (t.id == _currentTripId) {
        _trips[t.id] = await db.loadTripById(t.id);
      } else {
        _trips[t.id] = await db.lazyLoadTripById(t.id);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  // TripsProvider.from(this.db, List<Trip> trips) {
  //   _trips.addAll(trips);
  //   if (_trips.isNotEmpty) {
  //     _currentTripId = 0;
  //   }
  // }

  // sets the current Trip
  Future<void> select(int id) {
    return loadTrip(id).then((_) {
      _currentTripId = id;
      notifyListeners();
    });
  }

  void addFirst(Trip t) {
    // insert the trip to db and set it with the id given by db
    db.into(db.tripItems).insert(t.toCompanion()).then((id) {
      t.id = id;
      _trips[id] = t;
      _currentTripId = id;
      notifyListeners();
    });
  }

  Future<int> addTrip(Trip t) {
    // insert the trip to db and set it with the id given by db
    return db.into(db.tripItems).insert(t.toCompanion()).then((id) {
      t.id = id;
      _trips[id] = t;
      notifyListeners();
      return id;
    });
  }

  Future updateTrip(
    int tripId, {
    String? name,
    List<String>? destinations,
    DateTime? startDate,
    DateTime? endDate,
    String? defaultCurrency,
  }) async {
    if (_trips[tripId] == null) return;

    Trip updatedTrip = _trips[tripId]!.copyWith(
      name: name,
      destinations: destinations,
      startDate: startDate,
      endDate: endDate,
      defaultCurrency: defaultCurrency,
    );

    _trips[tripId] = updatedTrip;
    return db
        .updateTrip(updatedTrip.toCompanion())
        .then((_) => notifyListeners());
  }

  Future<Expense> updateExpense(
    Expense ex, {
    double? amount,
    String? desc,
    Budget? budget,
    String? currency,
    DateTime? time,
  }) async {
    Expense updatedExpense = ex.copyWith(
      amount: amount,
      desc: desc,
      budget: budget,
      currency: currency,
      time: time,
    );
    return db
        .updateExpense(updatedExpense.toCompanion())
        .then((_) => updatedExpense);
  }

  void removeTrip(int id) async {
    if (_trips[id] == null) {
      return;
    }
    for (Budget bud in _trips[id]!.budgets) {
      if (bud.id != null) {
        await db.removeBudget(bud.id!);
      }
    }
    for (Expense ex in _trips[id]!.expenses) {
      if (ex.id != null) {
        await db.removeExpense(ex.id!);
      }
    }
    await db
        .removeTrip(id)
        .then((_) async {
          // check if we to remove the seleced trip
          if (_currentTripId == id) {
            // select the first trip that is not the one we want to remove
            await select(_trips.keys.firstWhere((key) => key != id));
          }
        })
        .then((_) {
          _trips.remove(id);
          notifyListeners();
        });
  }

  void addBudget(Budget b) {
    trip!.addBudget(b);
    // insert budget to db and set budget id to id given by db
    db.into(db.budgetItems).insert(b.toCompanion()).then((id) => b.id = id);
    notifyListeners();
  }

  void addExpense(Expense ex, [Budget? b]) {
    if (b != null) {
      b.addExpense(ex);
    } else {
      trip!.addExpense(ex);
    }
    db.into(db.expenseItems).insert(ex.toCompanion()).then((id) => ex.id = id);
    notifyListeners();
  }
}
