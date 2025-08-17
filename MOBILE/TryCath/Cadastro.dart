import 'dart:io';

void main() {
  String nome = '';

  while (true) {
    stdout.write('Digite seu nome completo: ');
    String? entrada = stdin.readLineSync();

    if (entrada != null && entrada.trim().isNotEmpty) {
      nome = entrada.trim();
      break;
    } else {
      print('Nome inválido. Por favor, digite um nome válido.');
    }
  }

  print('Cadastro realizado com sucesso! Nome: $nome');
}
