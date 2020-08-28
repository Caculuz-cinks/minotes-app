import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  primaryColor: Colors.amber,
  accentColor: Colors.white,
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 1.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0)
    )
  ),
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.white, fontSize: 30.0),
    headline6: TextStyle(color: Colors.white, fontSize: 10.0),
    bodyText2: TextStyle(color: Colors.white, fontSize: 20.0),
    bodyText1: TextStyle(color: Colors.indigo)
  )
);