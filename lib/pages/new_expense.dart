import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double amount = 0;
  String? desc;
  Budget? budget;
  String? currency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Expense"),),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 10.5,
          children: [
            TextFormField(
              onSaved: (newValue) => amount = double.parse(newValue!),
              decoration: InputDecoration(hintText: "Enter amount", labelText: "Amount *"),
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value == null || value.isEmpty){
                  return "Please enter numbers.";
                }
                if (double.tryParse(value) == null){
                  return "Enter a real number.";
                }
                if (double.parse(value) <= 0) {
                  return "Please enter a number bigger than zero.";
                }
                return null;
              },
            ),
            Divider(),
            TextFormField(
              onSaved: (newValue) => desc = newValue,
              decoration: InputDecoration(hintText: "Enter description", labelText: "Description"),
            ),
            DropdownMenu(
              dropdownMenuEntries: List<DropdownMenuEntry>.from(context.read<Trip>().budgets.map((b) => DropdownMenuEntry(value: b, label: b.name))),
              hintText: "Select Budget",
              onSelected: (value) => budget = value as Budget?,
            ),
            TextFormField( // TODO: makes this a dropdown to select currency from a list of real currencies
              onSaved: (newValue) => currency = newValue,
              decoration: InputDecoration(hintText: "Enter currency", labelText: "Currency"),
            ),
            //TODO: add a datetime picker to pick a time for the expense (default is the time the expense was crated)
            Divider(),

            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                Navigator.pop(context, (amount: amount, desc: desc, budget: budget, currency: currency, time: DateTime.now()));
              }
            }, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}