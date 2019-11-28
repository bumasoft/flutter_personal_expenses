import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveAppBar {
  static Widget buildCupertinoAppBar(
    ThemeData theme,
    Widget title,
    Function action,
  ) {
    return CupertinoNavigationBar(
      backgroundColor: theme.primaryColorDark,
      middle: title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: action,
            child: Icon(
              CupertinoIcons.add,
              color: theme.textTheme.button.color,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildMaterialAppBar(
    Widget title,
    Function action,
  ) {
    return AppBar(
      title: title,
      actions: [
        IconButton(
          alignment: Alignment.centerRight,
          icon: Icon(Icons.add),
          onPressed: action,
        ),
      ],
    );
  }

  static PreferredSizeWidget build(
      {BuildContext ctx, Widget title, Function action}) {
    final _theme = Theme.of(ctx);

    return Platform.isIOS
        ? buildCupertinoAppBar(_theme, title, action)
        : buildMaterialAppBar(title, action);
  }
}
