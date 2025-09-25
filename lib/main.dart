import 'package:flutter/material.dart';
import 'package:wisebud/database/database.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/models/trips_provider.dart';
import 'package:wisebud/pages/budget_tab.dart';
import 'package:wisebud/pages/new_expense.dart';
import 'package:wisebud/pages/trip_tab.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider<TripsProvider>(
          create: (context) => TripsProvider(context.read<AppDatabase>()),
        ),
        ProxyProvider<TripsProvider, Trip?>(
          update: (context, tripsProvider, previousTrip) => tripsProvider.trip,
        ),
      ],
      child: MyApp(),
    ),
  );
}

//fake data
final Trip fakeTrip = Trip(
  name: 'My Dream Trip',
  destinations: ['Narnia', 'Rivendell', 'Asgard'],
  startDate: DateTime(2030, 1, 1),
  endDate: DateTime(2030, 6, 31),
  budgets: [
    Budget(
      name: 'Transportation',
      amount: 1000,
      expenses: [
        Expense(
          amount: 250,
          desc: "Flight to Narnia Internation Airport",
          currency: 'Narnia Sterling',
        ),
      ],
    ),
    Budget(
      name: 'gear',
      amount: 500,
      expenses: [Expense(amount: 500, desc: 'baggy bag')],
    ),
    Budget(
      name: 'accommodation',
      amount: 400,
      periodDays: 30,
      expenses: [
        Expense(amount: 15, time: DateTime(2030, 1, 1, 1)),
        Expense(amount: 12, time: DateTime(2030, 1, 2)),
        Expense(amount: 17, time: DateTime(2030, 1, 3)),
        Expense(amount: 14, time: DateTime(2030, 1, 4)),
      ],
    ),
    Budget(
      name: 'food',
      amount: 100,
      periodDays: 1,
      expenses: [
        Expense(amount: 15, desc: 'breakfast'),
        Expense(amount: 55, desc: 'lunch'),
        Expense(amount: 35, desc: 'dinner'), // over budget
      ],
    ),
  ],
);
final Trip fakeTrip2 = Trip(name: "my second trip");

// dump trip data to database for dev purposes // FIXME: not for prod
// Issue URL: https://github.com/Supalien/WiseBud/issues/21
void dumpTrip(AppDatabase db, Trip trip) async {
  int tripId = await db.into(db.tripItems).insert(trip.toCompanion());
  for (var b in trip.budgets) {
    b.tripId = tripId;
    int budgetId = await db.into(db.budgetItems).insert(b.toCompanion());
    for (var e in b.expenses) {
      e.budgetId = budgetId;
    }
  }
  for (var e in trip.expenses) {
    e.tripId = tripId;
    await db.into(db.expenseItems).insert(e.toCompanion());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 54, 170, 190),
          primary: Color.fromARGB(255, 54, 170, 190),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(202, 56, 2, 94),
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 126, 36, 190),
          dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
        ),
      ),
      home: DefaultTabController(length: 3, child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,

    TripsProvider tripsProvider = context.watch<TripsProvider>();

    if (tripsProvider.isLoading) {
      return CircularProgressIndicator(); // FIXME: this is ugly
                                          // Issue URL: https://github.com/Supalien/WiseBud/issues/20
    }

    if (tripsProvider.trip == null) { // ADDME: onboarding
                                      // Issue URL: https://github.com/Supalien/WiseBud/issues/19
      Trip firstTrip = Trip(name: "My first trip");
      tripsProvider.addFirst(firstTrip);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(context.select<Trip, String>((t) => t.name)),
        actions: [
          ElevatedButton(
            child: const Text('test button'),
            onPressed: () async {
              Stopwatch stopwatch = Stopwatch()..start();
              var db = context.read<AppDatabase>();
              dumpTrip(db, fakeTrip);
              dumpTrip(db, fakeTrip2);
              stopwatch.stop();
              print(stopwatch.elapsed.toString());
              tripsProvider.loadAll();
            },
          ),
        ],
      ),
      body: TabBarView(children: [TripTab(), BudgetTab(), Text('Settings tab')]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newExpense(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home_filled)),
          Tab(icon: Icon(Icons.monetization_on)),
          Tab(icon: Icon(Icons.settings)),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 75,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsetsGeometry.all(0),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsetsGeometry.all(5)),
                    Expanded(
                      child: Text("Trips", textScaler: TextScaler.linear(1.5)),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        Trip newTrip = Trip(
                          name: "test trip",
                        ); // TODO: Trip form
                           // Issue URL: https://github.com/Supalien/WiseBud/issues/27
                        tripsProvider.addTrip(newTrip);
                      },
                      label: Text("New Trip"),
                      icon: Icon(Icons.add_circle_sharp),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: List<Widget>.from(
                  tripsProvider.trips.map(
                    (t) => TextButton(
                      onPressed: () {
                        tripsProvider.select(t);
                        Navigator.pop(context); // close drawer
                      },
                      child: Text("Name: ${t.name}"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _newExpense(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NewExpenseScreen()),
  );

  if (!context.mounted) return; // widget doesnt exist
  if (result == null) return; // result of back button
  AppDatabase db = context.read<AppDatabase>();
  Expense newExpense = Expense(
    amount: result.amount,
    desc: result.desc,
    currency: result.currency,
    time: result.time,
  );
  context.read<TripsProvider>().addExpense(newExpense, result.budget);
  db
      .into(db.expenseItems)
      .insert(newExpense.toCompanion())
      .then((id) => newExpense.id = id);
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
