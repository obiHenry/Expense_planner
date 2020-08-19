import 'dart:ffi';

import 'package:flutter/material.dart';

class TransactionTextFields extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  final Function addTransaction;

  TransactionTextFields(this.addTransaction);

  @override
  _TransactionTextFieldsState createState() => _TransactionTextFieldsState();
}

class _TransactionTextFieldsState extends State<TransactionTextFields> {
  final titleController = TextEditingController();
  final amountcontroller = TextEditingController();

  Void submitData() {
    final enteredTitle = titleController.text;
    final enteredamount = double.parse(amountcontroller.text);

    if (enteredTitle.isEmpty || enteredamount <= 0) {
    } else {
      widget.addTransaction(
        enteredTitle,
        enteredamount,
      );
      Navigator.of(context).pop();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (val) => submitData(),
              // onChanged: (val) => titleInput = val,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcontroller,
              onSubmitted: (val) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
