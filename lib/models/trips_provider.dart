import 'package:flutter/widgets.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

// TODO: find a way to only load one trip at a time
// Issue URL: https://github.com/Supalien/WiseBud/issues/29
class TripsProvider with ChangeNotifier {
  AppDatabase db;
  final Map<int, Trip> _trips = {}; // map id to trip
  int _currentTripId = -1;
  bool isLoading = true;

  Map<int, Trip> get trips => _trips;
  Trip? get trip => _trips[_currentTripId];

  TripsProvider(this.db, {int? currentTripId}) {
    if (currentTripId != null && currentTripId >= 0 && _trips.containsKey(currentTripId)) {
      _currentTripId = currentTripId;
    }
    loadAll();
  }

  void loadTrip(int id) async {
    _trips[id] = await db.loadTripById(id);
  }

  void loadAll() async {
    _trips.clear();
    for (var t in await db.select(db.tripItems).get()) {
      if (t.id == _currentTripId) {
        _trips[t.id] = await db.loadTripById(t.id);
      }
      else {
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
  void select(int id) {
    loadTrip(id);
    _currentTripId = id;
    notifyListeners();
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

  void addTrip(Trip t) {
    // insert the trip to db and set it with the id given by db
    db.into(db.tripItems).insert(t.toCompanion()).then((id) { 
      t.id = id;
      _trips[id] = t;
    });
    notifyListeners();
  }

  // void addTrips(List<Trip> ts) {
  //   _trips.addAll(ts);
  //   if (_currentTripId == -1 && _trips.isNotEmpty) {
  //     _currentTripId = 0;
  //   }
  //   notifyListeners();
  // }

  // void removeTripAt(int i) {
  //   _trips.removeAt(i);
  //   if (_trips.isEmpty) {
  //     _currentTripId = -1;
  //   }
  //   if (i < _currentTripId) {
  //     _currentTripId--;
  //   }
  //   if (i == _currentTripId) {
  //     _currentTripId = 0;
  //   }
  //   notifyListeners();
  // }

  // void removeTrip(Trip t) {
  //   removeTripAt(_trips.indexOf(t));
  // }


  void addBudget(Budget b) {
    trip!.addBudget(b);
    // insert budget to db and set budget id to id given by db
    db.into(db.budgetItems).insert(b.toCompanion()).then((id) => b.id = id);
    notifyListeners();
  }

  void addExpense(Expense ex, [Budget? b]) {
    trip!.addExpense(ex);
    if (b != null) {
      b.addExpense(ex);
    }
    db.into(db.expenseItems).insert(ex.toCompanion()).then((id) => ex.id = id);
    notifyListeners();
  }
}
