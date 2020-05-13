import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Column(
            children: transactions.map((transaction) {                 // <------ Watch out with arrow fn in DART !!!
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        transaction.amount.toString()
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(transaction.title),
                        Text(transaction.date.toString()),
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
