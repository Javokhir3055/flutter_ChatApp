import 'package:flutter/material.dart';

var inputRegistrationScreen = InputDecoration(
  hintText: 'hint',
  hintStyle: TextStyle(color: Colors.black87),
  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
