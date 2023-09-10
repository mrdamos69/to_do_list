import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home.dart';
import 'package:to_do_list/pages/mainScreen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo' : (context) => Home(),
    },
  ));
}