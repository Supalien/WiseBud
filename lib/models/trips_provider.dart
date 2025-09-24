import 'package:flutter/widgets.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';

// TODO: find a way to only load one trip at a time
class TripsProvider with ChangeNotifier {
  AppDatabase db;
  final List<Trip> _trips = [];
  int _index = -1;
  bool isLoading = true;

  List<Trip> get trips => _trips;
  int get index => _index;
  Trip? get trip => _index != -1 ? _trips.elementAtOrNull(_index) : null;

  TripsProvider(this.db){
    loadAll();
  }
  Future<void> loadAll() async {
    for (var t in await db.select(db.tripItems).get()) {
      _trips.add(await db.loadTripById(t.id));
    }
    if (_index == -1) {
      _index = 0;
    }
    isLoading = false;
    notifyListeners();
  }

  TripsProvider.from(this.db, List<Trip> trips) {
    _trips.addAll(trips);
    if (_trips.isNotEmpty) {
      _index = 0;
    }
  }

  void addTrip(Trip t) {
    _trips.add(t);
    if (_index == -1) {
      _index = 0;
    }
    notifyListeners();
  }

  void addTrips(List<Trip> ts) {
    _trips.addAll(ts);
    if (_index == -1 && _trips.isNotEmpty) {
      _index = 0;
    }
    notifyListeners();
  }

  void removeTripAt(int i) {
    _trips.removeAt(i);
    if (_trips.isEmpty) {
      _index = -1;
    }
    if (i < _index) {
      _index--;
    }
    if (i == _index) {
      _index = 0;
    }
    notifyListeners();
  }

  void removeTrip(Trip t) {
    removeTripAt(_trips.indexOf(t));
  }

  // sets the current Trip
  void select(Trip t) {
    _index = _trips.indexOf(t);
    notifyListeners();
  }

  void addBudget(Budget b) {
    trip!.addBudget(b);
    notifyListeners();
  }

  void addExpense(Expense ex) {
    trip!.addExpense(ex);
    if (ex.budget != null) {
      ex.budget!.addExpense(ex);
    }
    notifyListeners();
  }
}
