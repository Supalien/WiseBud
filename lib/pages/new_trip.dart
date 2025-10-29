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

final DateTime firstDate = DateTime.fromMillisecondsSinceEpoch(0);
final DateTime lastDate = DateTime(9999);

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({
    super.key,
    this.name,
    this.destinations,
    this.startDate,
    this.endDate,
    this.defaultCurrency,
  });

  final String? name;
  final List<String>? destinations;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? defaultCurrency;

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = "";
  List<String> destinations = [];
  DateTime? startDate;
  DateTime? endDate;
  String? defaultCurrency;

  @override
  Widget build(BuildContext context) {
    name = widget.name ?? name;
    destinations = widget.destinations ?? destinations;
    startDate = widget.startDate;
    endDate = widget.endDate;
    defaultCurrency = widget.defaultCurrency;
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
                if (value != widget.name && context.read<TripsProvider>().trips.values.any(
                  (t) => t.name == value,
                )) {
                  return "Name should be unique.";
                }
                return null;
              },
              autofocus: true,
              initialValue: name,
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
                // ADDME: removable destinations
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
              firstDate: firstDate,
              lastDate: lastDate,
              fieldLabelText: "Start date",
              onDateSaved: (value) => startDate = value,
              acceptEmptyDate: true,
              initialDate: startDate,
            ),
            InputDatePickerFormField(
              firstDate: firstDate,
              lastDate: lastDate,
              fieldLabelText: "End date",
              onDateSaved: (value) => endDate = value,
              acceptEmptyDate: true,
              initialDate: endDate,
            ),

            TextFormField(
              onSaved: (newValue) => defaultCurrency = newValue!,
              decoration: InputDecoration(
                hintText: "Enter a currency",
                labelText: "Default Currency",
              ),
              initialValue: defaultCurrency,
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
