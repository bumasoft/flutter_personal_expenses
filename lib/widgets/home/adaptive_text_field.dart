import'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final String placeholder;
  final TextInputType keyboardType;

  AdaptiveTextField({this.controller, this.onSubmitted, this.placeholder, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: CupertinoTextField(
        placeholder: placeholder,
        controller: controller,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
      ),
    )
        : TextField(
      decoration: InputDecoration(
        labelText: placeholder,
      ),
      controller: controller,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
    );
  }
}
