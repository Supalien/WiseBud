import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/pages/new_trip.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, required this.tripId});

  final Trip trip;
  final int tripId;

  @override
  Widget build(BuildContext context) {
    TripsProvider tripsProvider = context.read<TripsProvider>();
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(trip.name),
        isThreeLine: true,
        // show destinations if exist. breaks the list to strings divided by ','
        subtitle: trip.destinations.isNotEmpty
            ? Text(
                "To ${trip.destinations.join(", ")}\n${trip.defaultCurrency}",
              )
            : Text(trip.defaultCurrency),
        trailing: TripMenuAnchor(tripId),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        selected: tripsProvider.trip == trip,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onTap: () {
          tripsProvider.select(tripId);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class TripMenuAnchor extends StatelessWidget {
  const TripMenuAnchor(this.tripId, {super.key});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    TripsProvider tripsProvider = context.read<TripsProvider>();
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: [
        MenuItemButton(
          trailingIcon: Icon(Icons.edit),
          onPressed: () => _editTrip(context, tripId),
          child: Text("Edit"),
        ),
        MenuItemButton(
          onPressed: () => tripsProvider.removeTrip(tripId),
          trailingIcon: Icon(Icons.delete),
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.error,
            ),
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.error,
            ),
          ),
          child: Text("Delete"),
        ),
      ],
    );
  }

  void _editTrip(BuildContext context, int tripId) async {
    TripsProvider tp = context.read<TripsProvider>();
    if (tp.trips[tripId] == null) return;
    Trip trip = tp.trips[tripId]!;
    // if the trip to edit is not the current trip, meaning is not already fully loaded
    if (trip.id != context.read<Trip>().id) {
      trip = await tp.loadTrip(tripId);
    }

    if (!context.mounted) return;
    final result = await Navigator.push<TripResult>(
      context,
      MaterialPageRoute(
        builder: (context) => NewTripScreen(
          name: trip.name,
          destinations: trip.destinations,
          startDate: trip.startDate,
          endDate: trip.endDate,
          defaultCurrency: trip.defaultCurrency,
        ),
      ),
    );

    if (result == null) return;

    await tp.updateTrip(
      tripId,
      
      name: result.name,
      destinations: result.destinations,
      startDate: result.startDate ?? trip.startDate,
      endDate: result.endDate ?? trip.endDate,
      defaultCurrency: result.defaultCurrency ?? trip.defaultCurrency,
    );
  }
}
      // leading: TextButton(
      //   onPressed: () {
      //     context.read<TripsProvider>().select(tripId);
      //     Navigator.pop(context); // close drawer
      //   },
      //   child: Text("Name: ${trip.name}"),
      // ),



      // IconButton(
      //   icon: Icon(Icons.more_vert),
      //   onPressed: () {
      //     print("menu pressed");
      //   },
      // ),