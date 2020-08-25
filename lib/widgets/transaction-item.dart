import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/Transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
  
}

class _TransactionItemState extends State<TransactionItem> {
  Color bgColors;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.pink,
    ];
    bgColors = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,

      child: ListTile(
          leading:
              // you can also build the circle avatar manually with this code
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
                backgroundColor: bgColors,
                radius: 30,
                child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                  color: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  label: Text('Delete'))
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                )),

      // u can as well build your card Structure codes if u dont want to use the already built in listTile by flutter with your own codes like this below
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
    );
  }
}
