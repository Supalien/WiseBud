import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/main.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/pages/new_expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key, this.onEdit, this.onDelete});

  final Expense expense;
  final Function? onEdit;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete?.call(),
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          onTap: () => _editExpense(context, expense),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          isThreeLine: true,
          title: Text("${expense.amount} ${expense.currency}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(expense.desc), Text(expense.time.toString())],
          ),
        ),
      ),
    );
  }

  void _editExpense(BuildContext context, Expense e) async {
    final result = await Navigator.push<ExpenseResult>(
      context,
      MaterialPageRoute(
        builder: (context) => NewExpenseScreen(
          amount: e.amount,
          desc: e.desc,
          budget: e.budget,
          currency: e.currency,
          time: e.time,
        ),
      ),
    );

    if (result == null) return;
    if (!context.mounted) return;

    Expense updatedExpense = await context.tripsProvider.updateExpense(
      e,
      amount: result.amount,
      desc: result.desc,
      budget: result.budget,
      currency: result.currency,
      time: result.time,
    );

    if (onEdit != null) {
      onEdit!(updatedExpense);
    }
  }
}
