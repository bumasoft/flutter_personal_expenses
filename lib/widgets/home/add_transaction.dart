import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';
import 'adaptive_text_field.dart';

class AddTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  AddTransaction(this._addNewTransaction);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate = DateTime.now();

  void _addTx() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
      return;
    }

    widget._addNewTransaction(
      enteredTitle,
      enteredAmount,
      _pickedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(ctx) {
    var initDate = DateTime.now();

    showDatePicker(
      context: ctx,
      initialDate: initDate,
      firstDate: DateTime(initDate.year),
      lastDate: initDate,
    ).then((value) {
      if (value == null) return;

      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _theme = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: _mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdaptiveTextField(
                placeholder: 'Title',
                controller: _titleController,
                onSubmitted: (_) => _addTx(),
              ),
              AdaptiveTextField(
                placeholder: 'Amount',
                controller: _amountController,
                onSubmitted: (_) => _addTx(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text('Date Picked: ${DateFormat.yMd().format(_pickedDate)}')),
                    AdaptiveFlatButton(
                      onPressed: () {
                        _presentDatePicker(context);
                      },
                      title: 'Choose Date',
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: AdaptiveFlatButton(
                    onPressed: _addTx,
                    title: 'Add Transaction',
                    color: _theme.accentColor,
                  )),
              if (Platform.isIOS)
                SizedBox(
                  height: 15,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
