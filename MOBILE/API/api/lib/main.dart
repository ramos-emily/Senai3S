import 'package:api/api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage()
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Variavel que observa o que o usuario digita :)😎
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  //Variavel com as informações corretas ✔🤔🐱‍🏍
  String correctUser = "a";
  String correctPassword = "123";

  //Variavel para mostrar o erro 👀
  String erro = "";

  //Funcao para validar as informações 
  void login() {
    if(user.text == correctUser && password.text == correctPassword){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ApiPage()));
    }else {
      setState(() {
        erro = "Existem credenciais erradas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Icon(Icons.person, size: 180, color: Colors.blue,),

              TextField(
                controller: user, //Aqui voce coloca a variavel que observa oq o usuario digita
                maxLength: 150, //Maximo de caracteres digitados 
                decoration: InputDecoration(
                  hintText: "Insira o seu nome", //Hint = Dica/o famoso "placeholder"
                  border: OutlineInputBorder(//cria borda
                    borderRadius: BorderRadius.circular(20), //Faz a circuferencia da borda
                    borderSide: BorderSide(
                      color: Colors.blue
                    )
                  )
                ),

              ),

              TextField(
                obscureText: true, //Deixa a senha privada *******
                controller: password, //Aqui voce coloca a variavel que observa oq o usuario digita
                maxLength: 150, //Maximo de caracteres digitados 
                decoration: InputDecoration(
                  hintText: "Insira sua senha", //Hint = Dica/o famoso "placeholder"
                  border: OutlineInputBorder(//cria borda
                    borderRadius: BorderRadius.circular(20), //Faz a circuferencia da borda
                    borderSide: BorderSide(
                      color: Colors.blue
                    )
                  )
                ),
              ),

              ElevatedButton(onPressed: login, child: Text("Login")),
              Text("$erro")




            ],
          )
        )
      )
    );
  }
}

