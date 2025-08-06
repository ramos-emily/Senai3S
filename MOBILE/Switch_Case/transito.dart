import 'dart:io';

void main() {
  print("Você deseja dar uma multa?: ");
  String? amarelinho = stdin.readLineSync();
  double multa = 0;

  while (amarelinho == "sim") {
    print("Digite o nome do motorista: ");
    String? name = stdin.readLineSync();

    print("Digite a velocidade do motorista: ");
    int velo = int.parse(stdin.readLineSync()!);

    if (velo <= 60) {
      print("Sem infração, ta livre fi");
      multa = 0;
    } else if (velo > 60 && velo <= 80) { 
      print("Infração leve, so uma multinha");
      multa = 250;
    } else if (velo > 80 && velo < 100) {
      print("Infração média! ta lascado viu");
      multa = 500;
    } else if (velo >= 100){
      print("Infração grave, se fu...");
      multa = 1000;
    }
    print("Sua multa ficou em $multa");
    print("Como voce deseja pagar?");
    print("1 - Pagar à vista (10% desconto)");
    print("2 - Parcelar 2x (sem juros)");
    print("3 - Parcelar 3x (com 10% de juros)");
    int pay = int.parse(stdin.readLineSync()!);

    switch(pay){
      case 1:
        double Desc10 = (multa*10)/100;
        double result = multa - Desc10;
        print("voce vai pagar $result com os 10% de desconto");
        break;
      case 2:
        double result = multa/2;
        print("Voce pagará duas parcelas de $result");
        break;
      case 3:
        double parcela = multa/3;
        double juros10 = (multa*10)/100;
        double result = multa + juros10;
        print("Voce pagará tres parcelas de $parcela com o total de juros ficando em $result");
        break;
    }
  }
}