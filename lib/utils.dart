import 'package:flutter/material.dart';

String formatDouble(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

bool isInThisMonth(DateTime d) {
  // var now = DateTime(2030, 1, 5); // for testing
  // FIXME: ABOVE LINE FOR TESTING PURPOSES ONLY! REPLACE LATER WITH BELOW LINE!
  var now = DateTime.now();
  var start = DateTime(now.year, now.month);
  var end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));
  return d.isAfter(start) && d.isBefore(end);
}

int currentMonthLength() {
  var now = DateTime.now();
  return DateTime(now.year, now.month + 1, 0).day; // some weird dart magic that doesnt make sense but works
}

int currentYearLength() {
  var now = DateTime.now();
  return DateTimeRange(
        start: DateTime(now.year),
        end: DateTime(now.year + 1),
      ).duration.inDays;
}