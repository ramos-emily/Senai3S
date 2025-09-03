import 'dart:io';

class Animals{
  String name;
  int age;

  Animals({required this.name, required this.age});
}

class Dog extends Animals{
  String? race;
  Dog({required String name, required int age, this.race}):super(name: name, age: age);

  void fazerSom(){
    print("auau");
  }

}

class Cat extends Animals{
  String? color;
  Cat({required String name, required int age, this.color}):super(name: name, age: age);

  void fazerSom(){
    print("miau");
  }
}


void main(){
  Dog salsicha = Dog(name: "Lilica", age: 7, race: "Salsichinha");
  Cat minecoon = Cat(name: "Sucsong", age: 6, color: "brown");
  salsicha.fazerSom();
  minecoon.fazerSom();
}


