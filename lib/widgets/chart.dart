import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bars.dart';
// import './user_transactions.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget{
  final List<Transactions> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get transactionDetails {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var amountSpend = 0.0;

      for(var i = 0; i<transactions.length; i++) {
        if(transactions[i].date.day == weekDay.day) {
          amountSpend += transactions[i].amount;
        } 
      }
      
      return {'weekDay': DateFormat.E().format(weekDay), 'amountSpend': amountSpend};
    }).reversed.toList();
  }
  
  double get totalWeekAmount {
    return transactionDetails.fold(0.0, (totalAmount, data) {
      return totalAmount + data['amountSpend'];
    });
}

  Widget build(BuildContext context) {
    // print(transactionDetails);
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionDetails.map((data) {
            return Flexible(fit: FlexFit.tight, child: ChartBar(data['weekDay'], data['amountSpend'], totalWeekAmount == 0 ? 0 : (data['amountSpend'] as double) / totalWeekAmount));
          }).toList()
        ),
      ),
    );
  }
}