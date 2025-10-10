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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  
                  children: [
                     Row(
                    
                 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 200,
                      
                      height: 230,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                        
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          Image.asset("assets/images/porcaoCoxinha.png",width: 150,),
                          Text("Coxinhas"),
                          Text("RS 100000,00"),
                          ElevatedButton(onPressed: () {}, child: Text("Faz o pix "))
                        ],
                      )

                      ),


                    ],
                  ),

                  ],
                )

                 


                
              ],
              
            );
            
          },
          
        ),
        
      ),
      
    );
  }
}

