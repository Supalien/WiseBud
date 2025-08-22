import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/pages/new_budget.dart';
import 'package:wisebud/utils.dart';

class BudgetTab extends StatefulWidget {
  const BudgetTab({super.key});

  @override
  State<BudgetTab> createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {
  String test = "";
  @override
  Widget build(BuildContext context) {
    List<Budget> budgets = context.select<Trip, List<Budget>>((t) => t.budgets);
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Budgets", textScaler: TextScaler.linear(2)),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List<Widget>.from(
              budgets.map((b) => BudgetInfoWidget(budget: b)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _createNewBudget(context);
            },
            child: Text("New Budget"),
          ),
        ],
      ),
    );
  }

  Future<void> _createNewBudget(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewBudgetScreen()),
    );

    if (!context.mounted) return; // widget doesnt exist
    if (result == null) return; // back button

    Budget nb = Budget(name: result.name, amount: result.amount, desc: result.desc);
    context.read<Trip>().addBudget(nb);
    setState((){});
  }
}

// make this a card widget
class BudgetInfoWidget extends StatelessWidget {
  final Budget budget;
  const BudgetInfoWidget({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    final bool isOverBudget = budget.totalExpenses >= budget.amount;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isOverBudget ? Colors.red : Colors.black,
          width: 2.0,
        ),
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