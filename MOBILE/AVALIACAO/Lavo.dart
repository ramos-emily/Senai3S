import 'dart:io';


String lerEntrada(String mensagem) {
  String entrada = "";
  while (entrada.trim().isEmpty) {
    stdout.write(mensagem);
    entrada = stdin.readLineSync() ?? "";
  }
  return entrada;
}

double lerNumero(String mensagem) {
  double? valor;
  while (valor == null) {
    stdout.write(mensagem);
    valor = double.tryParse(stdin.readLineSync() ?? "");
    if (valor == null || valor <= 0) {
      print("Valor inválido!");
      valor = null;
    }
  }
  return valor;
}

void main(){
  List<Map<String, dynamic>> produtos = [
    {"nome": "Lavar camisa", "preco": 5.0, "estoque": 10},
    {"nome": "Lavar calça", "preco": 8.0, "estoque": 10},
    {"nome": "Lavar terno", "preco": 25.0, "estoque": 10},
    {"nome": "Passar roupa", "preco": 3.0, "estoque": 15},
  ];

  List<Map<String, dynamic>> carrinho = [];

  print("Digite seu nome: ");
  String? name = stdin.readLineSync();

  print("Digite seu Documento: ");
  String? docs = stdin.readLineSync();

  bool continuar = true;

  while (continuar) {
    print("\n--- Produtos ---");
    for (int i = 0; i < produtos.length; i++) {
      print("$i - ${produtos[i]["nome"]} | "
            "R\$${produtos[i]["preco"]} | "
            "Estoque: ${produtos[i]["estoque"]}");
    }

    print("Escolha o produto (número): ");
    int escolha = int.parse(stdin.readLineSync()!);

    if (escolha == null || escolha < 0 || escolha >= produtos.length) {
      print("Opção inválida!");
      continue;
    }

    var produto = produtos[escolha];


    int? quant;
    while (true) {
      print("Quantos '${produto["nome"]}' deseja? ");
      quant = int.tryParse(stdin.readLineSync()!);

      if (quant == null || quant <= 0) {
        print("Quantidade inválida!!!!!!!!!!!!!!!");
        continue;
      }
      if (quant > produto["estoque"]) {
        print("Estoque insuficiente");
        continue;
      }
      break;
    }

    produto["estoque"] -= quant!;
    carrinho.add({
      "nome": produto["nome"],
      "preco": produto["preco"],
      "quantidade": quant,
    });

    print("Deseja adicionar mais itens? (s/n): ");
    String? mais = stdin.readLineSync() ?? "n";
    if (mais.toLowerCase() != "s") continuar = false;
  }

  double subtotal = 0;
  for (var item in carrinho){
    subtotal += item["preco"] * item["quantidade"];
  }

  print("\n--- Pagamento ---");
  print("1 - Dinheiro (10% de desconto)");
  print("2 - Débito (5% de desconto)");
  print("3 - Crédito (10% de juros)");
  print("4 - Pix (5% de desconto)");

  int? pag;
  while (pag == null){
    print("Escolha a forma de pagamento (número): ");
    pag = int.tryParse(stdin.readLineSync()!);
    if (pag == null || pag < 1 || pag > 4) {
      print("Opção invalida!!");
      pag = null;
    }
  }

  double desc = 0;
  double juros = 0;
  String textoForma = "";

  if (pag == 1) {
    textoForma = "Dinheiro";
    desc = subtotal * 0.10;
  } else if (pag == 2){
    textoForma = "Débito";
    desc = subtotal * 0.05;
  } else if (pag == 3){
    textoForma = "Crédito";
    juros = subtotal * 0.10;
  } else if (pag == 4){
    textoForma = "Pix";
    desc = subtotal * 0.05;
  }

  double total = subtotal - desc + juros;

  double troco = 0;
  if (pag == 1){
    double pago = lerNumero("Digite o valor entregue pelo cliente: ");
    troco = pago - total;
  }

  print("----RECIBO----");
  print("Cliente: $name");
  print("Cliente: $docs\n");

  for (var item in carrinho) {
    double valorItem = item["preco"] * item["quantidade"];
    print("${item["nome"]} - ${item["quantidade"]}x "
          "R\$${item["preco"]} = R\$${valorItem}");
  }

  print("\nSubtotal: R\$${subtotal}\n");
  if (desc > 0) print("desconto: -R\$${desc}\n");
  if (juros > 0) print("Juros: +R\$${juros}\n");
  print("Total: R\$${total}\n");
  print("Pagamento: $textoForma");
  if (troco > 0) print("Troco: R\$${troco}\n");
  print("==================");
}