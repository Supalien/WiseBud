import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/widgets/expenses_list.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage(this.budget, {super.key});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    TripsProvider tp = context.read<TripsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(budget.name),
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                trailingIcon: Icon(Icons.edit),
                onPressed: () => tp.updateBudget(),
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
          LinearProgressIndicator(value: budget.totalExpenses / budget.amount),
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
}
