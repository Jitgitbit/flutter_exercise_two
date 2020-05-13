import 'package:flutter/foundation.dart';

class Transaction {                                       // a normal class/object ! NOT A WIDGET !
  final String id;
  final String title;
  final double amount;                       // f.e.:  9.99 euro !
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
  });
}