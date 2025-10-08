import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                
                // Imagem de fundo
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: const BoxDecoration(                
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.jpg") ,
                      fit: BoxFit.cover,
                      
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),                       
                        
                        width: double.infinity,
                        child: 
                            Row(      
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,                              
                              children: [
                                
                                const Icon(Icons.search, size: 40.0, color:  Color.fromARGB(255, 168, 85, 16)),
                                Image.asset(
                              'assets/images/logo.png',
                              width: 120,
                              height: 80,
                              
                            ),
                            Icon(Icons.person, size: 40.0, color:   Color.fromARGB(255, 168, 85, 16)),
                              ],
                            )                        
                      ),
                    ],
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
