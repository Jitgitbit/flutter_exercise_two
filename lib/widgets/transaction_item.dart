import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadowColor: Theme.of(context).primaryColor,
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
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),  // two decimals!
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
          ? FlatButton.icon(
              onPressed: () => deleteTx(transaction.id),
              icon: const Icon(Icons.delete), 
              textColor: Theme.of(context).errorColor,
              label: const Text('Delete')               // this widget does not need a rebuild ever, so we can add const and
            )                                          // that way slightly improve performance
          : IconButton(
              icon: const Icon(Icons.delete), 
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTx(transaction.id),
            ),
      ),
    );
  }
}