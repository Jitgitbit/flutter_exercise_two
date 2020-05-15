import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);         // The Constructor ! transfering data from the parentWidget into this childWidget !!!

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,                                              // 450 looks great on Pixel 2, but this has to be dynamic at some point, responsive !
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],                                          // Using the .builder() is of CRUCIAL importance to keep a good performance    !!!!!
            )                                            // (ctx refers to context, which is meta-data that informs about relative position) !
          : ListView.builder(                           // Thanks to .builder() it only loads what is visible, instead of the entire list !!!!!
              itemBuilder: (ctx, index) {              // So obviously with long lists, this saves a lot of data being transferred !!!!!
                return Card(
                  shadowColor: Theme.of(context).primaryColor,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),  // two decimals!
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete
                      ), 
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
