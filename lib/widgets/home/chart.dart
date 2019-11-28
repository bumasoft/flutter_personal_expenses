import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions) {
    print('constructor chart');
  }

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      var total = 0.0;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.weekday == weekday.weekday) {
          total += _recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': total,
      };
    });
  }

  double get _maxSpending {
    return _groupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print('build() for chart');
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ..._groupedTransactionValues.reversed
                .map(
                  (item) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      item['day'],
                      item['amount'],
                      _maxSpending == 0.0
                          ? 0.0
                          : (item['amount'] as double) / _maxSpending,
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
