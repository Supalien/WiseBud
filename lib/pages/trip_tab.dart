import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/utils.dart';

class TripTab extends StatefulWidget {
  const TripTab({super.key});

  @override
  State<TripTab> createState() => _TripTabState();
}

class _TripTabState extends State<TripTab> {
  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<Trip>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            TripBudgetInfoWidget(title: "Trip Budget", currency: trip.defaultCurrency, amount: trip.totalExpenses, total: trip.totalBudget),
            TripBudgetInfoWidget(title: "Monthly budget", amount: trip.monthlyExpenses, currency: trip.defaultCurrency, total: trip.monthlyBudget),
          ],
        )
      ],
    );
  }
}

class TripBudgetInfoWidget extends StatelessWidget {
  final String title;
  final String currency;
  final double amount;
  final double total;
  const TripBudgetInfoWidget({super.key, required this.title, required this.currency, required this.amount, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Row(
          children: [
            Text(formatDouble(amount)),
            Text(' / '),
            Text(formatDouble(total)),
            Text(currency)
          ],
        )
      ],
    );
  }
}