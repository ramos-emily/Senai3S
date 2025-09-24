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
        appBar: AppBar(
          title: Text("Flutter Containers", style: TextStyle(color: Colors.white), ),
          centerTitle: true,
          
          backgroundColor: Colors.black,
        ),
        body: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30, 
              
              children: [
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
Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5LI3dU53ez_E5DRI6wcbk4cbYAW-ZFWkFIw&s",width: 500,)
              
              ],
            ),
      ),
    );
  }
}
