import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(
      this.transactions); // The Constructor ! transfering data from the parentWidget into this childWidget !!!

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(                              // Using the .builder() is of CRUCIAL importance to keep a good performance    !!!!!
        itemBuilder: (ctx, index) {                    // (ctx refers to context, which is meta-data that informs about relative position) !
          return Card(                                    // Thanks to .builder() it only loads what is visible, instead of the entire list !!!!!
            child: Row(                                  // So obviously with long lists, this saves a lot of data being transferred !!!!!
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                    width: 2,
                  )),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',           // two decimals, always
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
