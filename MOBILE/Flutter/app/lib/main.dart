import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //Casa de material de construção
      home: Scaffold( //divida em 2 (navBar e Main)
        appBar: AppBar(title: Text("aaaaaaaaaaaaaaaaaaaaaaaa"),), //navbar
        body: Container(
          width: 50,
          height: 50,
          color: Colors.red,
        )
      )
    );
  }
}

