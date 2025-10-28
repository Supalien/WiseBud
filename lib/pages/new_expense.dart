import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

typedef ExpenseResult = ({
  double amount,
  String? desc,
  Budget? budget,
  String? currency,
  DateTime? time,
});

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({
    super.key,
    this.amount,
    this.desc,
    this.budget,
    this.currency,
    this.time,
  });

  final double? amount;
  final String? desc;
  final Budget? budget;
  final String? currency;
  final DateTime? time;

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double amount = 0;
  String? desc;
  Budget? budget;
  String? currency;
  DateTime? time;

  @override
  Widget build(BuildContext context) {
    amount = widget.amount ?? amount;
    desc = widget.desc;
    budget = widget.budget;
    currency = widget.currency;
    time = widget.time;
    return Scaffold(
      appBar: AppBar(title: Text("New Expense")),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 10.5,
          children: [
            TextFormField(
              onSaved: (newValue) => amount = double.parse(newValue!),
              decoration: InputDecoration(
                hintText: "Enter amount",
                labelText: "Amount *",
              ),
              initialValue: amount == 0.0? null: amount.toString(),
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter numbers.";
                }
                if (double.tryParse(value) == null) {
                  return "Enter a real number.";
                }
                if (double.parse(value) <= 0) {
                  return "Please enter a number bigger than zero.";
                }
                return null;
              },
              autofocus: true,
            ),
            Divider(),
            TextFormField(
              onSaved: (newValue) => desc = newValue,
              decoration: InputDecoration(
                hintText: "Enter description",
                labelText: "Description",
              ),
              initialValue: desc,
            ),
            Row(
              children: [
                DropdownMenu(
                  dropdownMenuEntries: List<DropdownMenuEntry>.from(
                    context.read<Trip>().budgets.map(
                      (b) => DropdownMenuEntry(value: b, label: b.name),
                    ),
                  ),
                  hintText: "Select Budget",
                  onSelected: (value) => budget = value as Budget?,
                  initialSelection: budget, // safe because if budget is not in the list of enties, the dropdownmenu widget sets the selected index as undefined
                ),
              ],
            ),
            TextFormField(
              // ADDME: makes this a dropdown to select currency from a list of real currencies
              // Issue URL: https://github.com/Supalien/WiseBud/issues/24
              onSaved: (newValue) => currency = newValue,
              decoration: InputDecoration(
                hintText: "Enter currency",
                labelText: "Currency",
              ),
              initialValue: currency,
            ),
            // ADDME: improve time picker, with a date picker dialogue and a hour-minute time dialogue.
            // Issue URL: https://github.com/Supalien/WiseBud/issues/32
            InputDatePickerFormField(
              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: DateTime(9999),
              fieldLabelText: "Time",
              initialDate: time ?? DateTime.now(),
              onDateSaved: (value) => time = value,
              acceptEmptyDate: true,
            ),
            Divider(),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop<ExpenseResult>(context, (
                    amount: amount,
                    desc: desc,
                    budget: budget,
                    currency: currency,
                    time: time,
                  ));
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
