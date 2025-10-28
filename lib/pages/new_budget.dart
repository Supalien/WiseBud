import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/trip.dart';

typedef BudgetResult = ({
  String name,
  int amount,
  String? desc,
  Period period,
  int? customPeriod,
});

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({
    super.key,
    this.name,
    this.amount,
    this.desc,
    this.period,
    this.customPeriod,
  });

  final String? name;
  final int? amount;
  final String? desc;
  final Period? period;
  final int? customPeriod;
  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  int amount = 0;
  String? desc;
  Period period = Period.non;
  int? customPeriod;
  @override
  Widget build(BuildContext context) {
    name = widget.name ?? name;
    amount = widget.amount ?? amount;
    desc = widget.desc;
    period = widget.period ?? period;
    customPeriod = widget.customPeriod;
    return Scaffold(
      appBar: AppBar(title: Text("New Budget")),
      body: Form(
        key: _formKey,
        child: Column(
          spacing: 10.5,
          children: [
            TextFormField(
              onSaved: (newValue) => name = newValue!,
              decoration: InputDecoration(
                hintText: "Enter name",
                labelText: "Name *",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                if (List<String>.from(
                  context.read<Trip>().budgets.map((b) => b.name),
                ).contains(value)) {
                  return "Name should be unique.";
                }
                return null;
              },
              initialValue: name,
              autofocus: true,
            ),
            TextFormField(
              onSaved: (newValue) => amount = int.parse(newValue!),
              decoration: InputDecoration(
                hintText: "Enter amount",
                labelText: "Amount *",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some number";
                }
                if (int.tryParse(value) == null) {
                  // not numeric
                  return "Amount should be a number!";
                }
                if (int.parse(value) <= 0) {
                  return "Please enter a number bigger than zero.";
                }
                return null;
              },
              initialValue: amount == 0? null: amount.toString(),
              keyboardType: TextInputType.number,
            ),

            TextFormField(
              onSaved: (newValue) => desc = newValue!,
              decoration: InputDecoration(
                hintText: "Enter description",
                labelText: "Description",
              ),
              initialValue: desc,
            ),

            Row(children: [Text("Period", textScaler: TextScaler.linear(1.2))]),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  value: Period.non,
                  child: Text("Non-Periodic"),
                ),
                DropdownMenuItem(value: Period.daily, child: Text("Daily")),
                DropdownMenuItem(value: Period.weekly, child: Text("Weekly")),
                DropdownMenuItem(value: Period.monthly, child: Text("Monthly")),
                DropdownMenuItem(value: Period.yearly, child: Text("Yearly")),
                DropdownMenuItem(value: Period.custom, child: Text("Custom")),
              ],
              onChanged: (p) => setState(() {
                period = p ?? period;
                if (p != Period.custom) customPeriod = null;
              }),
              onSaved: (p) => period = p ?? period,
              value: period,
            ),

            if (period == Period.custom)
              TextFormField(
                onSaved: (newValue) =>
                    customPeriod = int.tryParse(newValue ?? ""),
                decoration: InputDecoration(hintText: "Enter number of days", labelText: "Custom period"),
                validator: (String? value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return "Please enter some number";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                initialValue: customPeriod?.toString(),
              ),

            Divider(),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop<BudgetResult>(context, (
                    name: name,
                    amount: amount,
                    desc: desc,
                    period: period,
                    customPeriod: customPeriod,
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
