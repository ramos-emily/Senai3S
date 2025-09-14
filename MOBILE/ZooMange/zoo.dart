import 'dart:io';

abstract class Animal {
  String _name;
  String size;

  Animal(this._name, this.size);

  String get name => _name;

  void emitirSom();
  void alimentar();
}

class Dog extends Animal {
  String? breed;

  Dog(String name, int age, String size, {this.breed}) : super(name, size);

  @override
  void emitirSom() {
    print("$name: auau!");
  }

  @override
  void alimentar() {
    print("$name está comendo ração de cachorro.");
  }
}

class Cat extends Animal {
  String? color;

  Cat(String name, int age, String size, {this.color}) : super(name, size);

  @override
  void emitirSom() {
    print("$name: miau!");
  }

  @override
  void alimentar() {
    print("$name está comendo ração de gato.");
  }
}

class Elephant extends Animal {
  double? weight;

  Elephant(String name, int age, String size, {this.weight}) : super(name, size);

  @override
  void emitirSom() {
    print("$name: sei la que barulho ele faz kkkkkkkk");
  }

  @override
  void alimentar() {
    print("$name está comendo feno e vegetais.");
  }
}

List<Animal> animais = [];

void cadastrarAnimal() {
  print("Digite o nome do animal:");
  String? name = stdin.readLineSync();

  print("Digite o porte do animal (pequeno/médio/grande):");
  String? size = stdin.readLineSync();

  print("Escolha a espécie: 1 - Cachorro, 2 - Gato, 3 - Elefante");
  int especie = int.parse(stdin.readLineSync()!);

  if (especie == 1) {
    print("Digite a raça do cachorro (opcional):");
    String? breed = stdin.readLineSync();
    animais.add(Dog(name!, 0, size!, breed: breed));
  } else if (especie == 2) {
    print("Digite a cor do gato (opcional):");
    String? color = stdin.readLineSync();
    animais.add(Cat(name!, 0, size!, color: color));
  } else if (especie == 3) {
    print("Digite o peso do elefante (opcional):");
    double? weight = double.tryParse(stdin.readLineSync()!);
    animais.add(Elephant(name!, 0, size!, weight: weight));
  }

  print("Animal cadastrado com sucesso!");
}

void listarAnimais() {
  if (animais.isEmpty) {
    print("Nenhum animal cadastrado.");
  } else {
    for (int i = 0; i < animais.length; i++) {
      print("$i - ${animais[i].name} (${animais[i].runtimeType}, Porte: ${animais[i].size})");
    }
  }
}

void editarAnimal() {
  listarAnimais();
  print("Digite o índice do animal que deseja editar:");
  int index = int.parse(stdin.readLineSync()!);

  if (index >= 0 && index < animais.length) {
    print("Digite o novo nome do animal:");
    String? novoNome = stdin.readLineSync();
    print("Digite o novo porte do animal:");
    String? novoPorte = stdin.readLineSync();

    Animal antigo = animais[index];
    if (antigo is Dog) {
      print("Digite a nova raça do cachorro:");
      String? breed = stdin.readLineSync();
      animais[index] = Dog(novoNome!, 0, novoPorte!, breed: breed);
    } else if (antigo is Cat) {
      print("Digite a nova cor do gato:");
      String? color = stdin.readLineSync();
      animais[index] = Cat(novoNome!, 0, novoPorte!, color: color);
    } else if (antigo is Elephant) {
      print("Digite o novo peso do elefante:");
      double? weight = double.tryParse(stdin.readLineSync()!);
      animais[index] = Elephant(novoNome!, 0, novoPorte!, weight: weight);
    }

    print("Animal editado com sucesso!");
  } else {
    print("Índice inválido.");
  }
}

void removerAnimal() {
  listarAnimais();
  print("Digite o índice do animal que deseja remover:");
  int index = int.parse(stdin.readLineSync()!);

  if (index >= 0 && index < animais.length) {
    animais.removeAt(index);
    print("Animal removido com sucesso!");
  } else {
    print("Índice inválido.");
  }
}

void filtrarPorPorte() {
  print("Digite o porte que deseja filtrar (pequeno/médio/grande):");
  String? porte = stdin.readLineSync();

  List<Animal> filtrados = animais.where((a) => a.size == porte).toList();

  if (filtrados.isEmpty) {
    print("Nenhum animal encontrado com porte $porte.");
  } else {
    for (var a in filtrados) {
      print("${a.name} (${a.runtimeType}, Porte: ${a.size})");
    }
  }
}

void gerarRelatorio() {
  Map<String, int> porEspecie = {};
  Map<String, int> porPorte = {};

  for (var a in animais) {
    String especie = a.runtimeType.toString();
    porEspecie[especie] = (porEspecie[especie] ?? 0) + 1;

    porPorte[a.size] = (porPorte[a.size] ?? 0) + 1;
  }

  print("===== Relatório de Animais =====");
  print("Por espécie:");
  porEspecie.forEach((k, v) => print("$k: $v"));

  print("Por porte:");
  porPorte.forEach((k, v) => print("$k: $v"));
}

void main() {
  while (true) {
    print("\n===== Sistema de Gestão ZOOMANGE =====");
    print("1 - Cadastrar animal");
    print("2 - Listar animais");
    print("3 - Editar animal");
    print("4 - Remover animal");
    print("5 - Filtrar por porte");
    print("6 - Gerar relatório");
    print("0 - Sair");

    int opcao = int.parse(stdin.readLineSync()!);

    if (opcao == 1) {
      cadastrarAnimal();
    } else if (opcao == 2) {
      listarAnimais();
    } else if (opcao == 3) {
      editarAnimal();
    } else if (opcao == 4) {
      removerAnimal();
    } else if (opcao == 5) {
      filtrarPorPorte();
    } else if (opcao == 6) {
      gerarRelatorio();
    } else if (opcao == 0) {
      print("Saindo...");
      break;
    } else {
      print("Opção inválida!");
    }
  }
}
