import 'dart:io';

void main() {
  stdout.write("Digite seu nome: ");
  String? nome = stdin.readLineSync();

  double soma = 0;

  for (int i = 1; i <= 3; i++) {
    double salario = -1;
    while (salario <= 0) {
      stdout.write("Digite o salário #$i: ");
      salario = double.tryParse(stdin.readLineSync()!) ?? -1;
    }
    soma += salario;
  }

  double media = soma / 3;

  print("\n$nome, sua média salarial é: R\$ ${media.toStringAsFixed(2)}");

  if (media < 2000) {
    print("Média salarial baixa.");
  } else if (media < 5000) {
    print("Média salarial média.");
  } else {
    print("Média salarial alta.");
  }
}


// import 'dart:io';

// void main(){

//   double nota = 0;
//   double result = 0;

//   for(double i = 0; i < 5; i++){
//     print("Digite uma nota: ");
//     double nota = double.parse(stdin.readLineSync()!);
//     result += nota;
//   }

//   double media = result / 5;

//   if(media < 4){
//     print("reprovou, melhore sua nota é: $media");
//   }else if(nota >= 5){ 
//     print("Passouuuu, tirou $media");
//   }else{
//     print("Recuperação mano, ficou com $media de nota");
//   }
// }
