import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;

  AdaptiveFlatButton({this.onPressed, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color != null ? color : _theme.primaryColor,
              ),
            ),
            onPressed: onPressed,
          )
        : FlatButton(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPressed,
            textColor: color != null ? color : _theme.primaryColor,
          );
  }
}
