import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'accounts.dart';
import 'stats.dart';

// import 'package:fintrack/forgot_password.dart';
// import 'package:fintrack/login.dart';
// import 'package:fintrack/signup.dart';
// import 'package:firebase_core/firebase_core.dart';

double income = 0;
double expense = 0;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MyApp(incm: income, exp: expense),
    ),
  );
}

List<String> list = <String>['Daily', 'Weekly', 'Monthly', 'Annually'];

const List<Widget> fruits = <Widget>[Text('INCOME'), Text('EXPENSE')];

class Transaction {
  DateTime dateTime;
  double amount;
  String type;
  int account;
  int category;
  String notes;

  Transaction(this.dateTime, this.amount, this.type, this.account,
      this.category, this.notes);
}

List<Transaction> trs = [];

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.incm, required this.exp}) : super(key: key);

  final double incm;
  final double exp;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Generate some dummy data for the cahrt
  final List<FlSpot> dummyData1 = List.generate(10, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(10, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String dropdownval = list.first;

  List<Widget> transactionWidgets = trs.map((transaction) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.money),
          ),
          title: Text("${transaction.amount}"),
          subtitle: Text("${transaction.type}"),
          trailing: Text("Utility"),
          tileColor: Colors.deepPurple.shade100,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: const Text('FINTRACK'),
              centerTitle: true,
              backgroundColor: Colors.blueGrey.shade200,
              elevation: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: DropdownButton<String>(
                value: dropdownval,
                style: TextStyle(color: Colors.purple.shade900, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.purple.shade900,
                ),
                items: list.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownval = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Center(
                    child: Text(
                      "Income: ${widget.incm}",
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 25.0,
                        color: Colors.white,
                        // backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade400),
                  child: Center(
                    child: Text(
                      "Expense: ${widget.exp}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.cyan),
              child: Center(
                child: Text(
                  "Total: ${widget.incm - widget.exp}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              // Within the `FirstRoute` widget
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
              child: Text("Add Transaction"),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(10),
              width: 340,
              height: 260,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    // The red line
                    LineChartBarData(
                      spots: dummyData1,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.red,
                    ),
                    // The orange line
                    LineChartBarData(
                      spots: dummyData2,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.green,
                    ),
                  ],
                  titlesData: FlTitlesData(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                      ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.money),
                        ),
                        title: Text("3500"),
                        subtitle: Text("Expense"),
                        trailing: Text("Utility"),
                        tileColor: Colors.deepPurple.shade100,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ] +
                    transactionWidgets,
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.query_stats,
            ),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final List<bool> selected_trs = <bool>[true, false];
  bool vertical = false;

  TextEditingController amtcontrol = TextEditingController();
  TextEditingController notecontrol = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Accounts'),
          content: SingleChildScrollView(
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(Icons.credit_card),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selected_trs.length; i++) {
                    selected_trs[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selected_trs,
              children: fruits,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.cyan.shade100,
                textStyle: TextStyle(fontSize: 20)),
            onPressed: () {
              _showMyDialog();
            },
            child: Text("Select  Account"),
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.green.shade100,
                textStyle: TextStyle(fontSize: 20)),
            onPressed: () {
              _showMyDialog();
            },
            child: Text("Select Category"),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: amtcontrol,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter the amount',
              constraints: BoxConstraints(
                maxWidth: 320,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: notecontrol,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add Notes',
              constraints: BoxConstraints(
                maxWidth: 320,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 20)),
                onPressed: () {
                  DateTime dt = new DateTime.now();
                  double amt = double.parse(amtcontrol.text);
                  String nt = notecontrol.text;
                  String ie;
                  if (selected_trs.first == true) {
                    income += amt;
                    ie = "income";
                  } else {
                    ie = "expense";
                    expense += amt;
                  }
                  Transaction newtrs = Transaction(dt, amt, ie, 0, 0, nt);
                  setState(() {
                    trs.add(newtrs);
                  });

                  amtcontrol.clear();
                  notecontrol.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp(
                              incm: income,
                              exp: expense,
                            )),
                  );
                },
                child: Text("Save"),
              ),
            ],
          )
        ],
      )),
    );
  }
}
