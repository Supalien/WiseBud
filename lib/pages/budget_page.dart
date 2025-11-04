import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/main.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/pages/new_budget.dart';
import 'package:wisebud/widgets/expenses_list.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage(this.budget, {super.key});

  final Budget budget;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  Budget? _budget;
  @override
  Widget build(BuildContext context) {
    Budget budget = _budget ?? widget.budget;
    TripsProvider tp = context.tripsProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(budget.name),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                trailingIcon: Icon(Icons.edit),
                onPressed: () {
                  _editBudget(context, budget, onEdit: (newBudget) {
                    setState(() {
                      _budget = newBudget;
                    });
                  });
                  },
                child: Text("Edit"),
              ),
              MenuItemButton(
                onPressed: () {
                  tp.removeBudget(budget);
                  Navigator.of(context).pop();
                },
                trailingIcon: Icon(Icons.delete),
                style: ButtonStyle(
                  iconColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                ),
                child: Text("Delete"),
              ),
            ],
            builder: (context, controller, child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: Icon(Icons.more_vert),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: budget.totalExpenses / budget.amount,
          ),
          Expanded(
            child: ExpensesList(
              expenses: budget.expenses,
              title: "Budget expenses:",
            ),
          ),
        ],
      ),
    );
  }

  void _editBudget(BuildContext context, Budget budget, {required Function(Budget) onEdit}) async {
    final result = await Navigator.push<BudgetResult>(
      context,
      MaterialPageRoute(
        builder: (context) => NewBudgetScreen(
          amount: budget.amount,
          name: budget.name,
          desc: budget.desc,
          period: budget.period,
          customPeriod: budget.customPeriod,
        ),
      ),
    );

    if (result == null) return;
    if (!context.mounted) return;

    Budget updatedBudget = await context.tripsProvider.updateBudget(
      budget,
      amount: result.amount,
      name: result.name,
      desc: result.desc,
      period: result.period,
      customPeriod: result.customPeriod,
    );

    onEdit(updatedBudget);
  }
}
