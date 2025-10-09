import 'package:flutter/material.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bgCardapio.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
