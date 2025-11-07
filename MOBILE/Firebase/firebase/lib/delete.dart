import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  List<dynamic>? values;


  @override
  initState() {
    super.initState();
    getValues();
  }

  void getValues() {
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshots){
        final data = snapshots.docs;
        setState(() {
          values = data;
        });
      }
    );
  }

  Future<void> deleteValue (String id) async {
    FirebaseFirestore.instance.collection("monitoramento").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}