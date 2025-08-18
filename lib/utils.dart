String formatDouble(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

bool isInThisMonth(DateTime d) {
  // var now = DateTime.now();
  // ***IMPORTANT: BELOW LINE FOR TESTING PURPOSES ONLY! REPLACE LATER WITH ABOVE LINE!
  var now = DateTime(2030, 1, 5); // for testing
  var start = DateTime(now.year, now.month, 1);
  var end = DateTime(now.year, now.month + 1).subtract(Duration(days: 1));
  return d.isAfter(start) && d.isBefore(end);
}
