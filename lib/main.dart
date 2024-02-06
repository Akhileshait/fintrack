import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Generate some dummy data for the cahrt
  // This will be used to draw the red line
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Column(
          children: [
            AppBar(
              title: const Text('FINTRACK'),
              centerTitle: true,
              backgroundColor: Colors.grey.shade400,
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
              onPressed: () {},
              child: Text("Add Transaction"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 20)),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
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
      ),
    );
  }
}
