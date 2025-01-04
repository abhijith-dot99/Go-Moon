import 'package:flutter/material.dart';
import 'package:go_moon/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
      ),
      title: 'Lunar Pass',
      home: Homepage(),
    );
  }
}
