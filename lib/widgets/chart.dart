import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {

    return List.generate(7, (index) {

      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++) {
        if(
          recentTransactions[i].date.day == weekDay.day &&
          recentTransactions[i].date.month == weekDay.month &&
          recentTransactions[i].date.year == weekDay.year
        ){
          totalSum += recentTransactions[i].amount;
        }
      }
      print('----> weekday says what?');
      print(DateFormat.E().format(weekDay));
      print('----> daily sum says what?');
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),      // thx substring
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element){      //--->  !!!!!!!! DART version of reduce !!!!!!!
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('---> groupedTransactionValues says what?');
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      shadowColor: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(20),
      child: Padding(                                           // Padding, the specialized Container, only to be used in case all you need is padding !
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
            // return Text('${data['day']}: ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight,                                     // force the child to use it's available space
              child: ChartBar(
                data['day'], 
                data['amount'], 
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending           // this ternary prevents crash in case of no data !!!
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}