import 'dart:io';
import 'dart:ffi';

import 'package:Expense_planner/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTextFields extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  final Function addTransaction;

  TransactionTextFields(this.addTransaction) {
    print('constructor TransactionTextField widget');
  }

  @override
  _TransactionTextFieldsState createState() {
    print('createState TransactionTextField widget');
    return _TransactionTextFieldsState();
  }
}

  class _TransactionTextFieldsState extends State<TransactionTextFields> {
  _TransactionTextFieldsState()  {
    print('createState TransactionTextField state');

  }

  @override
  void initState() {
    print('initState TransactionTextField state');
    super.initState();
  }

  @override
  void didUpdateWidget(TransactionTextFields oldWidget) {
    print('didUpdate TransactionTextField state');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('disposed TransactionTextField state');
    super.dispose();
  }
  final titleId = TextEditingController();
  final amountId = TextEditingController();


  DateTime _selectedDate;

  void pickDate(pickedDate) {
    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showDatePicker() {
    Platform.isIOS
        ? CupertinoDatePicker(
            onDateTimeChanged: (pickedDate) => pickDate(pickedDate),
          )
        : showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2022),
          ).then((pickedDate) {
            pickDate(pickedDate);
          });
  }

  Void submitData() {
    final enteredTitle = titleId.text;
    final enteredamount = double.parse(amountId.text);

    if (amountId.text.isEmpty) {
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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /* here use cupertinoTextField if on ios else use textField if on android */
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: titleId,
                      onSubmitted: (val) => submitData(),
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleId,
                      onSubmitted: (val) => submitData(),
                      // onChanged: (val) => titleInput = val,
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      keyboardType: TextInputType.number,
                      controller: amountId,
                      onSubmitted: (val) => submitData(),
                    )
                  : TextField(
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
                    Text(
                      _selectedDate == null
                          ? 'No Date chosen'
                          : '${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    AdaptiveButton('choose Date', _showDatePicker),
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
      ),
    );
  }
}
