import 'dart:io';

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/Transaction.dart';
import './widgets/transaction-list.dart';
import './widgets/transactionTextField.dart';
import './widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MainActivity());
}

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        /* this is incase you want to use cupertino themes but at the
     time of this project flutter doesnt have enough features the cupertino theme can use */
        //  Platform.isIOS ? CupertinoApp(
        //    title: ' Flutter app',
        //   theme: CupertinoThemeData(
        //     primaryColor: Colors.purple,
        //     primaryContrastingColor: Colors.white,

        //     accentColor: Colors.amber,
        //     fontFamily: 'Quicksand',
        //     errorColor: Colors.red,
        //     textTheme: ThemeData.light().textTheme.copyWith(
        //           headline6: TextStyle(
        //             fontFamily: 'OpenSans',
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           button: TextStyle(color: Colors.white),
        //         ),
        //     appBarTheme: AppBarTheme(
        //       textTheme: ThemeData.light().textTheme.copyWith(
        //             headline6: TextStyle(
        //               fontFamily: 'Quicksand',
        //               color: Colors.white,
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //     ),
        //   ),
        //   home: HomePage(),
        // ):
        MaterialApp(
      title: ' Flutter app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /* this is the container where the whole listed of items added
   are stored so to access this element u have to access _userTransaction */
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

  Void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: transactionTitle,
        amount: transactionAmount,
        date: chosenDate);

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

  void _deleteItemFromList(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  bool _showChart = false;

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionList,
  ) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Show chart',
          style: Theme.of(context).textTheme.headline6,
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ]),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : transactionList,
    ];
  }

  List<Widget> _buildPotraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionList,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      transactionList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isInLandscapeMode = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense_planner'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   icon: Icon(Icons.add),
                //   onPressed: () => _startAddNewtransaction(context),
                // ),
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewtransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expense_planner'),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewtransaction(context)),
            ],
          );

    final transactionList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        _userTransaction,
        _deleteItemFromList,
      ),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            if (!isInLandscapeMode)
              ..._buildPotraitContent(mediaQuery, appBar, transactionList),
            if (isInLandscapeMode)
              ..._buildLandscapeContent(mediaQuery, appBar, transactionList),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewtransaction(context),
                    child: Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
