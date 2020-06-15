import 'package:flutter/material.dart';

class SignInUpText extends StatelessWidget {
  final String text;
  const SignInUpText(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}
