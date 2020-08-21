import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transaction Yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: 
                    // Container(
                    //   height: 60,
                    //   width: 50,
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).primaryColor,
                    //     shape: BoxShape.circle,
                    //   ),

                    //   child: Padding(
                    //     padding: EdgeInsets.all(5),
                    //     child: FittedBox(
                    //         child: Text(
                    //             '\$${transactions[index].amount.toStringAsFixed(2)}',
                    //             style: TextStyle(color: Colors.white),
                    //             ),),
                    //   ),
                    // ),
                      CircleAvatar(
                      radius: 30,

                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                ),),
                      ),
                    ),

                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),

                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),

                    trailing: IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, onPressed: (){}),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Theme.of(context).primaryColor, width: 2),
                //         ),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           textAlign: TextAlign.end,
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(transactions[index].date),
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
