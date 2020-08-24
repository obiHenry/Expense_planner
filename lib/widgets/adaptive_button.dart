import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String choseDateText;
  final Function showDatePicker;
  AdaptiveButton(this.choseDateText, this.showDatePicker);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.blue,
            child: Text(
              choseDateText,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => showDatePicker(),
          )
        : FlatButton(
            onPressed: () => showDatePicker(),
            child: Text(
              "Choose Date",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
