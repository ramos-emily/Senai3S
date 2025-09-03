import 'dart:io';
import 'dart:mirrors';

class veiculo{
  String color;
  double year;
  String name;

  veiculo({required this.color, required this.name, required this.year});

  void mover(bool cnh){ //parametro (regra de nome do animal para pedir som)
    if(cnh == true){

    }else{

    }
  }
}

class car extends veiculo{
  car({required String color, required String name, required double year}): super(name: name, year: year, color: color);

  @override //subscreve ações da função
  void mover(bool cnh){

  }
}


class moto extends veiculo{
  moto({required String color, required String name, required double year}): super(name: name, year: year, color: color);

  @override
  void mover(bool cnh){
    if(cnh == true){
      print("Ajustar");
      print("Neutro");
      print("Cinto");
      print("Ligar");
      print("Primeira");
    }else{
      print("Pode nao man");
    }
  }
}

void main(){
  car civic = car(color: "blue", name: "vrum", year: 2000);
  civic.mover(true);

  moto cg = moto(color: "red", name: "radandan", year: 2023);
  cg.mover(true);
}