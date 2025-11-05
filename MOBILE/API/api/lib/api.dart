import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  String? value; 

  @override
  void initState() { //funcao que recarrega o estado da pagina , 
  //toda vez ao iniciar a pagina
    super.initState();
    getvalue(); //funcao que busca o valor , sera resetada sempre ao iniciar o app
  }

  void getvalue() async { //Funcao que pega o valor do http, precisa ser assincrona
    final response = await http.get(Uri.parse("https://api.serpwow.com/live/search?api_key=demo&search_type=places&q=pizza&location=lat:43.437677,lon:-3.8392765,zoom:15"));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        value = data["name"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: value == null ? CircularProgressIndicator() : Text("$value"),
      ),
    );
  }
}
