import 'dart:io';

void main(){
  List itens = [1.5, "True", 1, false];
  List<String> itenss = ["True"];
  String? item = stdin.readLineSync();

  itens.add(item!);
}