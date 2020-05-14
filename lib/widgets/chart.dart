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
        'day': DateFormat.E().format(weekDay).substring(0, 2),      // thx substring
        'amount': totalSum
      };
    });
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
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data){
          // return Text('${data['day']}: ${data['amount']}');
          return ChartBar(data['day'], data['amount'], (data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }
}