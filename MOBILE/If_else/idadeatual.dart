import 'dart:io';

void main() {
  print('Digite sua idade:');
  int idade = int.parse(stdin.readLineSync()!);
  print('No ano que vem você terá ${idade + 1} anos.');
}
