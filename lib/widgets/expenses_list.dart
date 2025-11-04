import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/main.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/widgets/expense_card.dart';

int _defaultComp(Expense a, Expense b) => a.time.compareTo(b.time);

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    this.title = "Latest expenses",
    this.compare = _defaultComp,
    this.reversed = true,
  });

  final List<Expense> expenses;
  final String title;
  final int Function(Expense, Expense)? compare;
  final bool reversed;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    List<Expense> sortedExpenses = List.from(widget.expenses)..sort(widget.compare);
    if (widget.reversed) {
      sortedExpenses = sortedExpenses.reversed.toList();
    }
    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaler: TextScaler.linear(1.2),
        ),
        Expanded(
          child: ListView(
            children: List<Widget>.from(
              sortedExpenses.map(
                (exp) => ExpenseCard(
                  exp,
                  onEdit: (newExp) {
                    setState(() {
                      widget.expenses[widget.expenses.indexOf(exp)] = newExp;
                    });
                  },
                  onDelete: () async {
                    context.tripsProvider.removeExpense(exp);
                    setState(() {
                      widget.expenses.remove(exp);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
