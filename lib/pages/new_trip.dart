import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/trips_provider.dart';

typedef TripResult = ({
  String name,
  List<String> destinations,
  DateTime? startDate,
  DateTime? endDate,
  String? defaultCurrency,
});

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = "unchanged";
  List<String> destinations = [];
  DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime endDate = DateTime(9999);
  String defaultCurrency = "USD";

  @override
  Widget build(BuildContext context) {
    TextEditingController destinationsController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("New Trip")),
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
                if (context.read<TripsProvider>().trips.values.any(
                  (t) => t.name == value,
                )) {
                  return "Name should be unique.";
                }
                return null;
              },
              autofocus: true,
            ),
            TextFormField(
              controller: destinationsController,
              onFieldSubmitted: (value) => setState(() {
                if (value.isEmpty || destinations.contains(value)) {
                  return;
                }
                destinations.add(value);
                destinationsController.clear();
              }),
              decoration: InputDecoration(
                hintText: "Add a destination",
                labelText: "Destinations",
              ),
            ),
            Row(
              spacing: 10,
              children: List<Widget>.from(
                destinations.map(
                  (d) => Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: ShapeDecoration(
                        shape: StadiumBorder(),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Text(d),
                    ),
                  ),
                ),
              ),
            ),

            InputDatePickerFormField(
              firstDate: startDate,
              lastDate: endDate,
              fieldLabelText: "Start date",
              onDateSaved: (value) => startDate = value,
              acceptEmptyDate: true,
            ),
            InputDatePickerFormField(
              firstDate: startDate,
              lastDate: endDate,
              fieldLabelText: "End date",
              onDateSaved: (value) => endDate = value,
              acceptEmptyDate: true,
            ),

            TextFormField(
              onSaved: (newValue) => defaultCurrency = newValue!,
              decoration: InputDecoration(
                hintText: "Enter a currency",
                labelText: "Default Currency",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop<TripResult>(context, (
                    name: name,
                    destinations: destinations,
                    startDate: startDate,
                    endDate: endDate,
                    defaultCurrency: defaultCurrency,
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
