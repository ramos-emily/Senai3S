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
         
        
        body: 
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 30, 
              
              children: [
          Stack(children: 

                    [
                      
                      
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.1,
                        color: const Color.fromARGB(0, 253, 252, 252),
                        child:
                        Center(child: Stack(
                          children: [
                                  Image.asset('assets/images/logo.png', width: double.infinity,height: 300,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    
                                    Icon(Icons.search, size: 30.0,),
                                    Container(child: Row(children: [
                                      Icon(Icons.person, size: 30.0,),
                                      Icon(Icons.store, size: 30.0,)
                                    ],),)
                                  ],)
                          ],
                        ))
                        
                      )


                          
                          ] ),

                Row(
                  spacing: 30, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Center(child: Text("1", style: TextStyle(color: Colors.white),),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Center(child: Text("2", style: TextStyle(color: Colors.white),),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 0, 0, 0),
                      
                      ),
                    ),
                  ],
                ),                
                Row(
                  spacing: 30, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Center(child: Text("3", style: TextStyle(color: Colors.white),),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Center(child: Text("4", style: TextStyle(color: Colors.white),),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 0, 0, 0),),),
                  ],
                  
                ),
                              Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                )
              
              ],
            ),
      ),
    );
  }
}
