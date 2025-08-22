import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/trip.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({super.key});

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  int amount = 0;
  String desc = "";
  // int periodDays = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a budget")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (newValue) => name = newValue!,
              decoration: InputDecoration(hintText: "Enter name", labelText: "Name *"),
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
            ),
            TextFormField(
              onSaved: (newValue) => amount = int.parse(newValue!),
              decoration: InputDecoration(hintText: "Enter amount", labelText: "Amount *"),
              validator: (String? value) {
                if (value == null || value.isEmpty){
                  return "Please enter some number";
                }
                if (int.tryParse(value) == null){ // not numeric
                  return "Amount should be a number!";
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            Divider(),
            TextFormField(
              onSaved: (newValue) => desc = newValue!,
              decoration: InputDecoration(hintText: "Enter description", labelText: "Description"),
            ),

            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                Navigator.pop(context, (name: name, amount: amount, desc: desc));
              }
            }, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
