import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
    ),
    home: Home(),
  ));
}