import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);         // The Constructor ! transfering data from the parentWidget into this childWidget !!!

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints){
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )
                  ),
                ],                                          
              );                                            // Using the ListView.builder() is of CRUCIAL importance to keep a good performance !!!!!
            })                                             // (ctx refers to context, which is meta-data that informs about relative position) !
          : ListView.builder(                             // Thanks to ListView.builder() it only loads what is visible, instead of the entire list !!!!!
              itemBuilder: (ctx, index) {                // So obviously with long lists, this saves a lot of data being transferred !!!!!
                return TransactionItem(
                  transaction: transactions[index],      // extracted TransactionItem, this time no performance gain, but more readability !
                  deleteTx: deleteTx
                );
              },
              itemCount: transactions.length,
            );
  }
}