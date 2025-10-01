import 'package:flutter/material.dart';

void main() {
  runApp(const TelaHome());
}

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPZR0ZB7PCULDaPus_EB7b-nQDRda3j_JcVA&s", width: 200,), //Image da internet
                  Image.asset("assets/images/images.png")
                ],               
              ),
              Row(
                children: [
                  Text("Gabriel é um bosta", style: TextStyle(
                    fontFamily: "font", fontSize: 80,
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
