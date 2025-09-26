import 'package:flutter/material.dart';

void main() {
  runApp(const Contador());
  


}

class Contador extends StatefulWidget { //full, dinamico
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("queroembora")),
        body: Column(
          children: [
            Text("0"),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                }, child: Icon(Icons.add))
              ],
            )

          ],
        ),
      ),
    ); //fornece components

  }
}
