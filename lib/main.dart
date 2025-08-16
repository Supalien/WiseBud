import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wisebud/models/budget.dart';
import 'package:wisebud/models/expense.dart';
import 'package:wisebud/models/trip.dart';
import 'package:wisebud/pages/login_page.dart';
import 'package:wisebud/pages/trip_tab.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://uqoxglavbjoaigeinuym.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxb3hnbGF2YmpvYWlnZWludXltIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxMTMyNzIsImV4cCI6MjA3MDY4OTI3Mn0.seNKHhjAj9uaqEeDhbc5cA2AhmwDRUl1jvqVfOuezAQ',
  );
  runApp(MyApp());
}

final SupabaseClient supabase = Supabase.instance.client;
//fake data
final Trip fakeTrip = Trip(
  name: 'mytrip',
  destinations: ['Narnia', 'Rivendell', 'Asgard'],
  startDate: DateTime(2030, 1, 1),
  endDate: DateTime(2030, 6, 31),
  budgets: [
    Budget(name: 'Transportation', amount: 1000, expenses: [
      Expense(amount: 250, desc: "Flight to Narnia Internation Airport", currency: 'Narnia Sterling')
    ]),
    Budget(name: 'gear', amount: 500, expenses: [
      Expense(amount: 500, desc: 'baggy bag')
    ]),
    Budget(name: 'accommodation', amount: 400, periodDays: 30, expenses: [
      Expense(amount: 15, time: DateTime(2030, 1, 1, 1)),
      Expense(amount: 12, time: DateTime(2030, 1, 2)),
      Expense(amount: 17, time: DateTime(2030, 1, 3)),
      Expense(amount: 14, time: DateTime(2030, 1, 4)),
    ]),
    Budget(name: 'food', amount: 100, periodDays: 1, expenses: [
      Expense(amount: 15, desc: 'breakfast'),
      Expense(amount: 55, desc: 'lunch'),
      Expense(amount: 35, desc: 'dinner') // over budget
    ])
  ]
  );

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 54, 170, 190)),
      ),
      home: DefaultTabController(length: 3, child: MyHomePage(trip: fakeTrip))
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.trip});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Trip trip;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Trip trip = widget.trip;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(trip.name),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: TabBarView(children: [
          TripTab(trip: trip),
          Text("Budgets tab"),
          Text('Auth tab')
        ])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FAB pressed'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: TabBar(tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.money)),
        Tab(icon: Icon(Icons.account_circle))
      ]),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
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
