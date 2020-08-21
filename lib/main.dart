import 'dart:ffi';
import 'dart:ui';

import './models/Transaction.dart';
import './widgets/transaction-list.dart';
import './widgets/transactionTextField.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainActivity());
}

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: ' Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',

        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: '1',
    //   title: 'new shoes',
    //   amount: 69.90,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'new watches',
    //   amount: 39.90,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '3',
    //   title: 'new clothes',
    //   amount: 69.90,
    //   date: DateTime.now(),
    // ),
  ];
/* here u get the user transaction dates 
starting from the present day to past seven days in alist */
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  Void _addNewTransaction(String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: transactionTitle,
        amount: transactionAmount,
        date: chosenDate
        );

    setState(() {
      _userTransaction.add(newTransaction);
    });
    return null;
  }

  void _startAddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: TransactionTextFields(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewtransaction(context)),
        ],
        title: Text('Expense_planner'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewtransaction(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
