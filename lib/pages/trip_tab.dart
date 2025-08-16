import 'package:flutter/material.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/utils.dart';

class TripTab extends StatefulWidget {
  final Trip trip;
  const TripTab({super.key, required this.trip});

  @override
  State<TripTab> createState() => _TripTabState();
}

class _TripTabState extends State<TripTab> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            BudgetInfoWidget(title: "Trip Budget", amount: widget.trip.getTotalExpenses(), total: widget.trip.getTotalBudget()),
            BudgetInfoWidget(title: "Monthly budget", amount: widget.trip.getMonthlyExpenses(), total: widget.trip.getMonthlyBudget()),
          ],
        )
      ],
    );
  }
}

class BudgetInfoWidget extends StatefulWidget {
  final String title;
  final String? currency;
  final double amount;
  final double total;

  const BudgetInfoWidget({super.key, required this.title, this.currency, required this.amount, required this.total});
  @override
  State<BudgetInfoWidget> createState() => _BudgetInfoWidgetState();
}

class _BudgetInfoWidgetState extends State<BudgetInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
        Row(
          children: [
            Text(formatDouble(widget.amount)),
            Text(' / '),
            Text(formatDouble(widget.total)),
            Text(widget.currency ?? " USD")
          ],
        )
      ],
    );
  }
}