import 'package:flutter/material.dart';
import 'main.dart'; // Importa sua página principal

class Nada extends StatelessWidget {
  const Nada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          // Texto centralizado
          Center(
            child: Text(
              'tem nada aqui mano',
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.normal,
              ),
            ),
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
                  backgroundColor:
                      const Color.fromARGB(255, 168, 85, 16).withOpacity(0.3),
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
    );
  }
}
