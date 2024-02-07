import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

const List<Widget> fruits = <Widget>[Text('INCOME'), Text('EXPENSE')];

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Generate some dummy data for the cahrt
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
          child: Column(
        children: [
          AppBar(
            title: const Text('FINTRACK'),
            centerTitle: true,
            backgroundColor: Colors.grey.shade400,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              hint: Text("Choose"),
              focusColor: Colors.amberAccent,
              items: <String>['Daily', 'Weekly', 'Monthly', 'Annually']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Income",
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "Expenses",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Text(
            "Total",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: 25.0,
              color: Colors.white,
            ),
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
                backgroundColor: Colors.blue.shade300,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 30,
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
              ),
            ),
          ),
        ],
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
  final List<bool> _selectedFruits = <bool>[true, false];
  bool vertical = false;

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
                  for (int i = 0; i < _selectedFruits.length; i++) {
                    _selectedFruits[i] = i == index;
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
              isSelected: _selectedFruits,
              children: fruits,
            ),
          )
        ],
      )),
    );
  }
}
