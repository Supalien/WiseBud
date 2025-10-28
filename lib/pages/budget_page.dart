import 'package:flutter/material.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/widgets/expenses_list.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage(this.budget, {super.key});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(budget.name), actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
      ],),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: budget.totalExpenses / budget.amount,
          ),
          Expanded(child: ExpensesList(expenses: budget.expenses, title: "Budget expenses:",))
        ],
      ),
    );
  }
}
