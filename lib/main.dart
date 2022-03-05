import 'package:basic_sqflite/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Qsflite Demo",
      theme: ThemeData(primarySwatch:Colors.blue),
      home:const HomeScreen(),
    );
  }
}
