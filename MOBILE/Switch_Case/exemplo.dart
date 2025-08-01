// logica simples switch, logica complexa ifelse

//Entrada valores fixos.

import 'dart:io';

void main(){
  print("Insira a sua nota");
  double nota = double.parse(stdin.readLineSync()!);
  switch(nota){
    case 1:
      print("1");
      break;
    case 2:
      print("2");
      break;
    case 3:
      print("3");
      break;
    default:
      print("cabo");
  }
  print("fora do switch");
}