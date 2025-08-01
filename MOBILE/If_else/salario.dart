import 'dart:io';

void main(){

  double salario = 0;
  double result = 0;

  print("Digite seu nome: ");
  String? name = stdin.readLineSync();

  for(double i = 0; i < 3; i++){
    print("Digite seus tres ultimos salarios: ");
    double salario= double.parse(stdin.readLineSync()!);
    result += salario;
  }

  double media = result / 3;

  if(salario == String){
    print("digite um salario valido!");
  }
}