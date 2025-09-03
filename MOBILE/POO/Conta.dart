import 'dart:io';

class Conta {
  String name;
  double saldo;
  double? invest;

  Conta({required this.name, required this.saldo, this.invest});
}

class ContaCorrente extends Conta{
  double? LCE;

  ContaCorrente({required String name, required double saldo, double? invest, this.LCE}):super(name: name, saldo: saldo, invest: invest);

  void mostrar_saldo(){
    print(saldo);
  }
}

class ContaPoupanca extends Conta{
  double TR;

  ContaPoupanca({required String name, required double saldo, double? invest, required this.TR}):super(name: name, saldo: saldo, invest: invest);

  void atualizar_saldo(){
    saldo += TR; //15 reais , 1000 + 15 = 1015
    print(saldo);
  }

}

void main(){
  ContaCorrente a = ContaCorrente(name: "badesco", saldo: 2000, invest: 200, LCE: 1000);
  ContaPoupanca b = ContaPoupanca(name: "santo andré", saldo: 5000, invest: 200, TR: 20);
  b.atualizar_saldo();
  a.mostrar_saldo();
}