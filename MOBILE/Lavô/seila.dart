import 'dart:io';

// Função para ler entrada não vazia
String lerEntrada(String mensagem) {
  String entrada = "";
  while (entrada.trim().isEmpty) {
    stdout.write(mensagem);
    entrada = stdin.readLineSync() ?? "";
  }
  return entrada;
}

// Função para ler número com validação
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

void main() {
  // Lista de produtos (usando Map)
  List<Map<String, dynamic>> produtos = [
    {"nome": "Lavar camisa", "preco": 5.0, "estoque": 20},
    {"nome": "Lavar calça", "preco": 8.0, "estoque": 15},
    {"nome": "Lavar terno", "preco": 25.0, "estoque": 10},
    {"nome": "Passar roupa", "preco": 3.0, "estoque": 30},
  ];

  // Carrinho
  List<Map<String, dynamic>> carrinho = [];

  // --- Cadastro do cliente ---
  String nomeCliente = lerEntrada("Digite o nome do cliente: ");
  String docCliente = lerEntrada("Digite o documento do cliente: ");

  // --- Escolha dos produtos ---
  bool continuar = true;
  while (continuar) {
    print("\n--- Produtos ---");
    for (int i = 0; i < produtos.length; i++) {
      print("$i - ${produtos[i]["nome"]} | "
            "R\$${produtos[i]["preco"]} | "
            "Estoque: ${produtos[i]["estoque"]}");
    }

    int? escolha;
    stdout.write("Escolha o produto (número): ");
    escolha = int.tryParse(stdin.readLineSync() ?? "");

    if (escolha == null || escolha < 0 || escolha >= produtos.length) {
      print("Opção inválida!");
      continue;
    }

    var produto = produtos[escolha];

    int? qtd;
    while (true) {
      stdout.write("Quantos '${produto["nome"]}' deseja? ");
      qtd = int.tryParse(stdin.readLineSync() ?? "");
      if (qtd == null || qtd <= 0) {
        print("Quantidade inválida!");
        continue;
      }
      if (qtd > produto["estoque"]) {
        print("Estoque insuficiente, escolha menor.");
        continue;
      }
      break;
    }

    // Atualiza estoque e adiciona ao carrinho
    produto["estoque"] -= qtd;
    carrinho.add({
      "nome": produto["nome"],
      "preco": produto["preco"],
      "quantidade": qtd,
    });

    stdout.write("Deseja adicionar mais itens? (s/n): ");
    String op = stdin.readLineSync() ?? "n";
    if (op.toLowerCase() != "s") continuar = false;
  }

  // --- Subtotal ---
  double subtotal = 0;
  for (var item in carrinho) {
    subtotal += item["preco"] * item["quantidade"];
  }

  // --- Forma de pagamento ---
  print("\n--- Pagamento ---");
  print("1 - Dinheiro (10% de desconto)");
  print("2 - Débito (5% de desconto)");
  print("3 - Crédito (10% de juros)");
  print("4 - Pix (5% de desconto)");

  int? forma;
  while (forma == null) {
    stdout.write("Escolha a forma de pagamento: ");
    forma = int.tryParse(stdin.readLineSync() ?? "");
    if (forma == null || forma < 1 || forma > 4) {
      print("Opção inválida!");
      forma = null;
    }
  }

  double desconto = 0;
  double juros = 0;
  String formaTexto = "";

  if (forma == 1) {
    formaTexto = "Dinheiro";
    desconto = subtotal * 0.10;
  } else if (forma == 2) {
    formaTexto = "Débito";
    desconto = subtotal * 0.05;
  } else if (forma == 3) {
    formaTexto = "Crédito";
    juros = subtotal * 0.10;
  } else if (forma == 4) {
    formaTexto = "Pix";
    desconto = subtotal * 0.05;
  }

  double total = subtotal - desconto + juros;

  // --- Troco se for dinheiro ---
  double troco = 0;
  if (forma == 1) {
    double pago = lerNumero("Digite o valor entregue pelo cliente: ");
    troco = pago - total;
  }

  // --- Recibo ---
  print("\n===== RECIBO =====");
  print("Cliente: $nomeCliente");
  print("Documento: $docCliente\n");

  for (var item in carrinho) {
    double valorItem = item["preco"] * item["quantidade"];
    print("${item["nome"]} - ${item["quantidade"]}x "
          "R\$${item["preco"]} = R\$${valorItem}");
  }

  print("\nSubtotal: R\$${subtotal.toStringAsFixed(2)}");
  if (desconto > 0) print("Desconto: -R\$${desconto.toStringAsFixed(2)}");
  if (juros > 0) print("Juros: +R\$${juros.toStringAsFixed(2)}");
  print("Total: R\$${total.toStringAsFixed(2)}");
  print("Pagamento: $formaTexto");
  if (troco > 0) print("Troco: R\$${troco.toStringAsFixed(2)}");
  print("==================");
}
