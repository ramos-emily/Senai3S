import 'dart:io';

void main() {
  double valorCompra = 0;

  while (true) {
    print("Digite o valor da compra: ");
    String? entrada = stdin.readLineSync();

    if (entrada == null || entrada.trim().isEmpty) {
      print('Não pode ser vazio.');
      continue;
    }

    try {
      valorCompra = double.parse(entrada);
      if (valorCompra <= 0) {
        print('deve ser maior que zero.');
        continue;
      }
      break;
    } catch (e) {
      if (e is FormatException) {
        print('Entrada inválida. Digite um número válido.');
      } else {
        print('Erro: $e');
      }
    }
  }

  print('Valor da compra: R\$${valorCompra.toStringAsFixed(2)}');

  int formaPagamento = 0;
  while (true) {
    print("\nEscolha a forma de pagamento:");
    print("1 – Dinheiro");
    print("2 – Cartão de Débito");
    print("3 – Cartão de Crédito");
    print("4 – Pix");

    print("Digite o número correspondente: ");
    String? entradaPagamento = stdin.readLineSync();

    if (entradaPagamento == null || entradaPagamento.trim().isEmpty) {
      print('Opção inválida. Digite um número entre 1 e 4.');
      continue;
    }

    try {
      formaPagamento = int.parse(entradaPagamento);
      if (formaPagamento < 1 || formaPagamento > 4) {
        print('Opção inválida. Digite um número entre 1 e 4.');
        continue;
      }
      break; 
    } catch (e) {
      if (e is FormatException) {
        print('Entrada inválida. Digite um número entre 1 e 4.');
      } else {
        print('Erro inesperado: $e');
      }
    }
  }

  String forma = '';
  switch (formaPagamento) {
    case 1:
      forma = 'Dinheiro';
      break;
    case 2:
      forma = 'Cartão de Débito';
      break;
    case 3:
      forma = 'Cartão de Crédito';
      break;
    case 4:
      forma = 'Pix';
      break;
  }

  print('\nResumo da compra:');
  print('Valor: R\$${valorCompra.toStringAsFixed(2)}');
  print('Forma de pagamento: $forma');
}
