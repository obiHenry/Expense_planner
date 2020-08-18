import 'package:Expense_planner/Transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainActivity());
}

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Flutter app',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> transaction = [
    Transaction(
      id: '1',
      title: 'new Shoes',
      amount: 99.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'weekly Groceries',
      amount: 59.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Expense_planner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.pink,
              child: Text('CHART'),
              elevation: 20,
            ),
          ),
          Column(
            children: transaction.map((transactions) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        transactions.amount.toString(),
                      ),
                    ),

                    Column(children: [
                      Text(transactions.title),
                      Text(transactions.date.toString()),
                    ],)
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
