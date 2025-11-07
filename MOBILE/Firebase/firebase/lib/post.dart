import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController novatemperatura = TextEditingController();

  Future<void> postValue () async {
    FirebaseFirestore.instance.collection("monitoramento").add(
      {
        "temperatura": novatemperatura.text
      }
    );

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:Text("Tela Post")),
        body:Center(child:Column(children: [
          TextField(
            controller: novatemperatura,
            

          ),
          ElevatedButton(onPressed: postValue, child: Text("Enviar dados"))
        ],))
      )
    );
  }
}
