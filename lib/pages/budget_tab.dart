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
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Text("Budgets", textScaler: TextScaler.linear(2)),
          GridView.count(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            crossAxisCount: 2,
            clipBehavior: Clip.none,
            children: List<Widget>.from(
              budgets.map(
                (b) => ChangeNotifierProvider.value(
                  value: b,
                  child: BudgetInfoWidget(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _newBudget(context);
            },
            child: Text("New Budget"),
          ),
        ],
      ),
    );
  }

  Future<void> _newBudget(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewBudgetScreen()),
    );

    if (!context.mounted) return; // widget doesnt exist
    if (result == null) return; // back button

    Budget nb = Budget(
      name: result.name,
      amount: result.amount,
      desc: result.desc,
    );
    context.read<Trip>().addBudget(nb);
    setState(() {});
  }
}

class BudgetInfoWidget extends StatelessWidget {
  const BudgetInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Budget budget = context.watch<Budget>();
    final bool isOverBudget = budget.totalExpenses >= budget.amount;
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isOverBudget ? Colors.red : Colors.black,
            width: 2.0,
          ),
        ),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: (){}, // TODO: open budget editor screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(budget.name),
              Text(
                '${formatDouble(budget.totalExpenses)} / ${budget.amount} ${context.read<Trip>().defaultCurrency}',
              ),
              Text("${100 * budget.totalExpenses / budget.amount}%")
            ],
          ),
        ),
      ),
    );
  }
}
