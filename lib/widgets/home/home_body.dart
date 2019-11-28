import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/transaction.dart';
import 'transaction_list.dart';
import 'chart.dart';

class HomeBody {
  static Widget build({
    BuildContext ctx,
    bool showChart,
    double screenHeight,
    List<Transaction> userTransactions,
    Function deleteTransaction,
    Function switchChanged,
  }) {
    final _mediaQuery = MediaQuery.of(ctx);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;
    final _theme = Theme.of(ctx);

    final List<Transaction> _recentTransactions = userTransactions
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(
              Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();

    List<Widget> _buildLandscapeContent(Widget txListWidget) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show Chart', style: _theme.textTheme.body1),
            Switch.adaptive(
              activeColor: _theme.accentColor,
              value: showChart,
              onChanged: switchChanged,
            ),
          ],
        ),
        if (showChart)
          Container(
            height: screenHeight * 0.5,
            child: Chart(_recentTransactions),
          ),
        if (!showChart) txListWidget
      ];
    }

    List<Widget> _buildPortraitContent(Widget txListWidget) {
      return [
        Container(
          height: screenHeight * 0.3,
          child: Chart(_recentTransactions),
        ),
        txListWidget,
      ];
    }

    final _txListWidget = Container(
        height: screenHeight * 0.7,
        child: TransactionList(userTransactions, deleteTransaction));

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape) ..._buildLandscapeContent(_txListWidget),
            if (!_isLandscape) ..._buildPortraitContent(_txListWidget),
          ],
        ),
      ),
    );
  }
}
