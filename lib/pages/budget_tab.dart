import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/utils.dart';

class BudgetTab extends StatefulWidget {
  const BudgetTab({super.key});

  @override
  State<BudgetTab> createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {
  @override
  Widget build(BuildContext context) {
    List<Budget> budgets = context.select<Trip, List<Budget>>((t) => t.budgets);
    return Column(
      children: [
        Text("Budgets", textScaler: TextScaler.linear(2)),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List<Widget>.from(
            budgets.map((b) => BudgetInfoWidget(budget: b)),
          ),
        ),
      ],
    );
  }
}

class BudgetInfoWidget extends StatelessWidget {
  final Budget budget;
  const BudgetInfoWidget({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    final bool isOverBudget = budget.totalExpenses >= budget.amount;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isOverBudget? Colors.red : Colors.black,
          width: 2.0
        )
      ),
      child: Column(
        children: [
          Text(budget.name),
          Text(
            '${formatDouble(budget.totalExpenses)} / ${budget.amount} ${context.read<Trip>().defaultCurrency}',
          ),
        ],
      ),
    );
  }
}
