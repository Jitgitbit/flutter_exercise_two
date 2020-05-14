import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_exercise_two/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'new shoes', amount: 69.99, date: DateTime.now(),),
    Transaction(id: 't2', title: 'new hat', amount: 39.99, date: DateTime.now(),),
  ];

  String titleInput;
  String amountInput;                                 // important ! inputs always have to be strings, so in case of number, it needs to be converted !!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          Card(
            elevation: 5,
            child: Padding(                                    // Padding is a Container widget dedicated to add only a padding !
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (value) => titleInput = value,                // note the two differnt syntax options and their requirements !
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    onChanged: (val) {
                      amountInput = val;                                    // note the two differnt syntax options and their requirements !
                    } ,
                  ),
                  FlatButton(
                    child: Text('Add Transaction'),
                    textColor: Colors.purple,
                    onPressed: () {
                      print('Here under is titleInput');
                      print(titleInput);                                    // Different way of logging !!!!!! DART !!!
                      print('Here under is amountInput');
                      print(amountInput);
                    }, 
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((transaction) {                 // <------ Watch out with arrow fn in DART !!!
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        )
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${transaction.amount}',                  
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(transaction.date),           
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
