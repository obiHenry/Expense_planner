import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTextFields extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  final Function addTransaction;

  TransactionTextFields(this.addTransaction);

  @override
  _TransactionTextFieldsState createState() => _TransactionTextFieldsState();
}

class _TransactionTextFieldsState extends State<TransactionTextFields> {
  final titleId = TextEditingController();
  final amountId = TextEditingController();
  

  DateTime _selectedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2022),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  Void submitData() {
    final enteredTitle = titleId.text;
    final enteredamount = double.parse(amountId.text);
  

    if(amountId.text.isEmpty){
      return null;
    }

    if (enteredTitle.isEmpty || enteredamount <= 0 || _selectedDate == null) {
    } else {
      widget.addTransaction(
        enteredTitle,
        enteredamount,
        _selectedDate,
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
              controller: titleId,
              onSubmitted: (val) => submitData(),
              // onChanged: (val) => titleInput = val,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountId,
              onSubmitted: (val) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 90,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date chosen'
                      : '${DateFormat.yMd().format(_selectedDate)}'
                      ),
                  FlatButton(
                    onPressed: () => _showDatePicker(),
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
              ),
              textColor: Theme.of(context).textTheme.button.color,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
