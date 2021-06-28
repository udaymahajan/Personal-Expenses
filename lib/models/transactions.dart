import 'package:flutter/foundation.dart';

class Transactions {
  final String title;
  final double amount;
  final DateTime date;
  final String id;

  Transactions(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
