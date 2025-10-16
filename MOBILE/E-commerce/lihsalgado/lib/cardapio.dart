import 'package:flutter/material.dart';
import 'main.dart'; // Importe a sua página Main

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background
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

            // Conteúdo principal
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 230,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/porcaoCoxinha.png",
                            width: 150,
                          ),
                          Text("Coxinhas"),
                          Text("RS 100000,00"),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Faz o pix "),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Botão voltar estilizado no canto superior esquerdo
            Positioned(
              top: 40,
              left: 10,
              child: SizedBox(
                width: 150,
                height: 45,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 168, 85, 16).withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
