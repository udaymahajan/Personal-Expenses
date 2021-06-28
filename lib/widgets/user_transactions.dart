import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class UserTransactions extends StatelessWidget {
  UserTransactions(this._transactions, this.delTx);

  final List<Transactions> _transactions;
  final Function delTx;


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 565,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(vertical:8, horizontal:5),
                child: ListTile(
                leading: CircleAvatar(radius: 30, child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox( child: Text('₹${_transactions[index].amount}')),
                )),
                title: Text(_transactions[index].title),
                subtitle: Text(DateFormat.yMMMd().format(_transactions[index].date)),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (_) => AlertDialog(
                      title: Text('Delete?'),
                      content: Text('Are you sure to delete this record?'),
                      actions: [
                        TextButton(child: Text('No'), onPressed: () => Navigator.of(context, rootNavigator: true).pop(),),
                        TextButton(child: Text('Yes'), onPressed: () => delTx(_transactions[index].id),),
                      ],
                )),),
            ),
              );
          },
          itemCount: _transactions.length,
        ));
  }
}
