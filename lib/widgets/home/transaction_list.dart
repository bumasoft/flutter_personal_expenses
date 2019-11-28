import 'package:flutter/material.dart';

import '../../models/transaction.dart';

import 'transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final Function _deleteTx;
  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return _userTransactions.isEmpty
          ? Column(
              children: [
                Text('No transactions added yet.',
                    style: _theme.textTheme.title),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionListItem(
                  transaction: _userTransactions[index],
                  theme: _theme,
                  mediaQuery: _mediaQuery,
                  deleteTx: _deleteTx,
                );
              },
              itemCount: _userTransactions.length,
            );
    });
  }
}
