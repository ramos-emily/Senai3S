import 'dart:io';

void main(){
  //?Opcional Indicaque a variavel pode ser nula
  String? entrada = stdin.readLineSync();
  //Precisa que a entrada tenha valor
  //para poder converter
  int idade = int.parse(entrada!);

  if(idade >=18){
    print("Voce pode dirigir, ta habilitado");
  }
  else{
    print("Voce não pode dirigir");
  }
}