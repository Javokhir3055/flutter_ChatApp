import 'package:flutter/material.dart';

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
          child: Hero(
        tag: 'logo',
        child: Container(
          child: Image.asset('images/logo.png'),
          height: 200,
        ),
      ),
    );
  }
}