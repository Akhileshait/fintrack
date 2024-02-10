import 'package:flutter/material.dart';

// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';

void main() {
  runApp(MaterialApp(
    home: myStats(),
  ));
}

class myStats extends StatelessWidget {
  const myStats({super.key});
   @override

  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
     body: Column(
      
      
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height:40,
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
        "Accounts",
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 25.0,
                  color: Colors.black,
                )
        ),
           
          
          ],
          
        ),
        SizedBox(
          height:10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
            "Avl Balance: 100",
              style: TextStyle(
                fontSize: 23.0,
              ),
           )
          ],
        ),
          SizedBox(
            height: 20,
          ),
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text("Bank Account"),
              tileColor: Colors.blue.shade100,
              
            ),
          ],
        ),
         SizedBox(
          height: 15,
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Credit Card "),
              tileColor:Colors.blue.shade100,
              
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),

         Column(
          children: [
            ListTile(
              leading: Icon(Icons.money),
              title: Text("Cash"),
              tileColor: Colors.blue.shade100,
              
            ),
          ],
        ),
        
      ],

      

    ),
     
   

     
    );
  }


  

  
}