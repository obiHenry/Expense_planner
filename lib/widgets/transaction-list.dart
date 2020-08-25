import './transaction-item.dart';
import 'package:flutter/material.dart';
import '../models/Transaction.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (context, constrants) {
                return Column(
                  children: [
                    Container(
                      height: constrants.maxHeight * 0.25,
                      child: Text(
                        'No Transaction Yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: constrants.maxHeight * 0.5,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                );
              })
            : 
        // ListView.builder(
        //     itemBuilder: (context, index) {
        //       return TransactionItem(
        //         transaction: transactions[index],
        //         deleteTransaction: deleteTransaction,
        //         );

        //     },itemCount: transactions.length,
        //   )
//here you can equally use a column and a singlechildscrollView to achieve what listview.building is doing that is displaying a listview
        SingleChildScrollView(
                child: Column(
                
                  children: 
                    
                    transactions.map((transaction) {
                      return TransactionItem(
                        key: ValueKey(transaction.id),
                          transaction: transaction,
                          deleteTransaction: deleteTransaction);
                    }).toList()
                  ,
                ),
            )
        );
  }
}
