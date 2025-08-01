import 'dart:io'; //importa as funções da linguagem dart

void main(){
  print("Digite seu nome");
  String? nome = stdin.readLineSync(); //Input

  print("Parabens campeão você é demais seu nome é $nome");//Valor da variavel

  if(nome == "junin"){
    print("Você é o cara, parabens campeão");
  }
  else{
    print("Você não é o campeão, mehore");
  }


  //versao int


  print("Digite sua idade: ");
  String? idade = stdin.readLineSync(); //Input
  int anos = int.parse(idade!);

  print("Parabens campeão, sua idade é $idade");//Valor da variavel

  if(idade == 20){
    print("Você é o cara, parabens campeão");
  }
  else{
    print("Você não é o campeão, mehore");
  }
}