import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../global.dart';

import '../../models/transaction.dart';

import 'adaptive_appbar.dart';
import 'add_transaction.dart';
import 'home_body.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  void _deleteTransaction(id) {
    setState(() {
      _userTransactions.removeWhere((elem) => elem.id == id);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime pickedDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: pickedDate,
      id: pickedDate.toString(),
    );

    setState(() => _userTransactions.add(newTx));
  }

  void _addTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          child: AddTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);

    final _appBarTitle = Text(
      Config.appTitle,
      style: _theme.appBarTheme.textTheme.title,
    );

    final PreferredSizeWidget _appBarWidget = AdaptiveAppBar.build(
      ctx: context,
      title: _appBarTitle,
      action: () {
        _addTransactionModal(context);
      },
    );

    var screenHeight = (_mediaQuery.size.height -
        _appBarWidget.preferredSize.height -
        _mediaQuery.padding.top);

    final _appBody = HomeBody.build(
      ctx: context,
      showChart: _showChart,
      screenHeight: screenHeight,
      userTransactions: _userTransactions,
      deleteTransaction: _deleteTransaction,
      switchChanged: (val) {
        setState(() {
          _showChart = val;
        });
      },
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _appBody,
            navigationBar: _appBarWidget,
          )
        : Scaffold(
            appBar: _appBarWidget,
            body: _appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      _addTransactionModal(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
