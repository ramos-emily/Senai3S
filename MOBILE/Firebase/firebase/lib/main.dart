import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaGet()
    );
  }
}


class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  String? temperatura;

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshot){
        final data = snapshot.docs.first.data();

        setState(() {
          temperatura = data["temperatura"];
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return temperatura == null ? Center(child: CircularProgressIndicator()) :
     Center(child: Column(children: [
      Text("$temperatura"),
      ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PostPage()));
      }, child: Text("Pagina de Post"))
     ],),);
  }
}



