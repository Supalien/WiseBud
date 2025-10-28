import 'package:flutter/material.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/pages/trip_tab.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, this.title = "Latest expenses"});

  final List<Expense> expenses;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$title:",
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaler: TextScaler.linear(1.2),
        ),
        Expanded(
          child: ListView(
            children: List<Widget>.from(
              expenses.map(
                (exp) => ExpenseCard(exp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
