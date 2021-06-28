import 'package:flutter/material.dart';
import './widgets/user_transactions.dart';
import './widgets/transactions_update.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactions> _transactions = [
    // Transactions(
    //   title: 'New Clothes',
    //   amount: 18,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'New bag',
    //   amount: 18,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'New watch',
    //   amount: 18,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'Groceries',
    //   amount: 30,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'Eatables',
    //   amount: 12,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'Apparels',
    //   amount: 50,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   title: 'Party',
    //   amount: 200,
    //   id: DateTime.now().toString(),
    //   date: DateTime.now(),
    // ),
  ];

  List<Transactions> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _function(String title, double amount, DateTime pickedDate) {
    final newTransaction = Transactions(
      title: title,
      amount: amount,
      id: DateTime.now().toString(),
      date: pickedDate,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _fx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UpdateTransaction(_function);
        });
  }

  void _deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _fx(context);
          },
        ),
      ],
    );

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        title: 'Personal Expenses',
        home: Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(recentTransactions)),
                _transactions.length == 0
                    ? Container(
                        padding: EdgeInsets.only(top:10),
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.48,
                        child: Image.asset(
                          'assets/images/emptylist_4x.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: UserTransactions(_transactions, _deleteTx)),
              ])),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _fx(context),
          ),
        ));
  }
}
