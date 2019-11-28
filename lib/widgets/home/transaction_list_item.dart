import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import'../../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key key,
    @required Transaction transaction,
    @required ThemeData theme,
    @required MediaQueryData mediaQuery,
    @required Function deleteTx,
  })  : _transaction = transaction,
        _theme = theme,
        _mediaQuery = mediaQuery,
        _deleteTx = deleteTx,
        super(key: key);

  final Transaction _transaction;
  final ThemeData _theme;
  final MediaQueryData _mediaQuery;
  final Function _deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('\$${_transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          _transaction.title,
          style: _theme.textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMEEEEd().format(_transaction.date),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: _mediaQuery.size.width > 500
            ? FlatButton.icon(
          textColor: _theme.errorColor,
          onPressed: () {
            _deleteTx(_transaction.id);
          },
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: _theme.errorColor,
          onPressed: () {
            _deleteTx(_transaction.id);
          },
        ),
      ),
    );
  }
}
