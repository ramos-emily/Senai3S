import 'dart:io';

void main(){

  double nota = 0;
  double result = 0;

  for(double i = 0; i < 5; i++){
    print("Digite uma nota: ");
    double nota = double.parse(stdin.readLineSync()!);
    result += nota;
  }

  double media = result / 5;

  if(media < 4){
    print("reprovou, melhore sua nota é: $media");
  }else if(nota >= 5){ 
    print("Passouuuu, tirou $media");
  }else{
    print("Recuperação mano, ficou com $media de nota");
  }
}