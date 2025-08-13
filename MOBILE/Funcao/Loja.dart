import 'dart:io';

void main() {
  print("Digite o preço original do produto:");
  double precoOriginal = double.parse(stdin.readLineSync()!);
  
  print("Digite a porcentagem de desconto:");
  double porcentagemDesconto = double.parse(stdin.readLineSync()!);

  double precoFinal = calcularDesconto(precoOriginal, porcentagemDesconto);
  
  print("\nPreço original: R\$ $precoOriginal");
  print("Desconto: $porcentagemDesconto%");
  print("Preço final: R\$ $precoFinal");
}

double calcularDesconto(double preco, double desconto) {

  double valorDesconto = preco * (desconto / 100);
  
  double precoComDesconto = preco - valorDesconto;
  
  return precoComDesconto;
}