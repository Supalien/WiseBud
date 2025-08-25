import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/utils.dart';

class TripTab extends StatelessWidget {
  const TripTab({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<Trip>();
    return Column(
      children: [
        Padding(padding: EdgeInsetsGeometry.only(bottom: 25)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TripBudgetInfoWidget(
              title: "Trip Budget",
              currency: trip.defaultCurrency,
              amount: trip.totalExpenses,
              total: trip.totalBudget,
            ),
            TripBudgetInfoWidget(
              title: "Monthly budget",
              amount: trip.monthlyExpenses,
              currency: trip.defaultCurrency,
              total: trip.monthlyBudget,
            ),
          ],
        ),
      ],
    );
  }
}

class TripBudgetInfoWidget extends StatelessWidget {
  final String title;
  final String currency;
  final double amount;
  final double total;
  const TripBudgetInfoWidget({
    super.key,
    required this.title,
    required this.currency,
    required this.amount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 65,
      child: Material(
        color: Theme.brightnessOf(context) == Brightness.dark? Theme.of(context).focusColor : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.shadow,
        child: InkWell(
          onTap: () {}, // TODO: do something with this
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                Text(
                  "${formatDouble(amount)} / ${formatDouble(total)} $currency",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}