import './chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
// create a constructor for getting the recent transaction date and last seven days
  Chart(this.recentTransaction);
/* here you get list of the days u want to b displayed and the  total sum of 
transactions of all the last seven days transaction store it in transactionValues */
  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDday = DateTime.now().subtract(
        Duration(days: index),
      );

      // here get the toatal transaction amount for the last seven days
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDday.day &&
            recentTransaction[i].date.month == weekDday.month &&
            recentTransaction[i].date.year == weekDday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      print(DateFormat.E().format(weekDday));
      print(totalSum);

      //show the days and the total amount
      return ({
        'day': DateFormat.E().format(weekDday).substring(0, 1),
        'amount': totalSum
      });
    });
  }
  // here u get total money spent 
  double get totalSpending {
    return transactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(transactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // put the transaction value to map container(transactions) and then display on the chartbar
          children: transactionValues.map((transactions) {
        return Flexible(
          fit: FlexFit.tight,
                  child: ChartBar(
            transactions['day'],
            transactions['amount'],
            totalSpending == 0.0
                ? 0.0
                : (transactions['amount'] as double) / totalSpending,
          ),
        );
      }).toList()),
    );
  }
}
