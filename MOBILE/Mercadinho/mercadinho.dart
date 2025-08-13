import 'dart:io';

void main() {
  List<String> itensDisponiveis = [
    "Arroz",
    "Feijão",
    "Macarrão",
    "Leite",
    "Pão",
    "Ovos",
    "Açúcar"
  ];

  print("===== BEM-VINDO AO MERCADINHO DA FAISQUINHA =====");
  print("Itens disponíveis para compra:");
  for (var item in itensDisponiveis) {
    print("- $item");
  }

  stdout.write("\nDigite o CPF do cliente: ");
  String cpf = stdin.readLineSync()!;

  List<Map<String, dynamic>> compras = [];
  double total = 0.0;

  bool continuar = true;

  while (continuar) {
    stdout.write("\nDigite o nome do item: ");
    String nomeItem = stdin.readLineSync()!;

    stdout.write("Digite o valor do item: R\$ ");
    double valorItem = double.parse(stdin.readLineSync()!);

    compras.add({"nome": nomeItem, "valor": valorItem});
    total += valorItem;

    stdout.write("Deseja incluir mais itens? (SIM/NÃO): ");
    String resposta = stdin.readLineSync()!.toUpperCase();
    if (resposta != "SIM") {
      continuar = false;
    }
  }

  print("\n===== RESUMO DA COMPRA =====");
  for (var item in compras) {
    print("${item['nome']} - R\$ ${item['valor'].toStringAsFixed(2)}");
  }
  print("Total da compra: R\$ ${total.toStringAsFixed(2)}");

  int? opcao;
  do {
    print("\nEscolha a forma de pagamento:");
    print("1 - À vista (10% de desconto)");
    print("2 - Parcelado no cartão (10% de juros)");
    print("3 - Fiado (15% a mais para a próxima compra)");
    stdout.write("Digite a opção (1, 2 ou 3): ");
    opcao = int.tryParse(stdin.readLineSync()!);
  } while (opcao == null || !(opcao == 1 || opcao == 2 || opcao == 3));

  double totalFinal = total;

  switch (opcao) {
    case 1:
      totalFinal = total * 0.9;
      print("Pagamento à vista. Total com desconto: R\$ ${totalFinal.toStringAsFixed(2)}");
      break;
    case 2:
      totalFinal = total * 1.1;
      print("Pagamento parcelado no cartão. Total com juros: R\$ ${totalFinal.toStringAsFixed(2)}");
      break;
    case 3:
      totalFinal = total * 1.15;
      print("Compra fiada. Total para pagar na próxima compra: R\$ ${totalFinal.toStringAsFixed(2)}");
      break;
  }

  print("\nObrigado por comprar no Mercadinho do Bairro!");
}
