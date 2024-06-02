import 'package:flutter/material.dart';
import 'accounts.dart';
import 'stats.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadIncomeAndExpense();
  }

  void _loadIncomeAndExpense() async {
    await loadIncomeAndExpense();
    trs = await getAllTransactions();
    setState(() {}); // Trigger a rebuild after loading values
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Home(incm: income, exp: expense),
      myStats(),
      account(),
      SafeArea(
          child: Center(
        child: Text("More..."),
      ))
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: _widgetOptions.elementAt(_selectedIndex),
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
