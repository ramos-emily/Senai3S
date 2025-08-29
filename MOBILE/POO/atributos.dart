import 'dart:io';

// class Products{
//   String name;
//   double price;
//   String? description;

//   Products({required this.name,
//   required this.price,
//   this.description});
// }

// void main(){
//   Products Coca = Products(name: "Coquinha geladinha", price: 8);
//   Products Fanta = Products(name: "Fantinha gelada", price: 7, description: "Essa coca é fanta");
// }

// class Fds extends Products{
//   Fds({required String name,
//   required double price, 
//   String? description
//   }):super(name: name, price: price, description: description);
// }

class Produtos{
  //atributos
  String name;
  double price;
  String? description;

  //construtor
  Produtos({required this.name, required this.price, this.description
  });
}

//classe pra herdar
class refri extends Produtos{
  String? marca; // no refri pq é dele
  refri({required String name, required double price, this.marca, String? description}):super(name: name, price: price, description: description);
} 

void main (){
  refri coca = refri(name: "coca", price: 8, marca: "coca-cola", description: "aaaaaaaaaaa");
  refri fantinha = refri(name: "fantinha", price: 8, marca: "fantinha", description: "bbbbbbbbbb");

}