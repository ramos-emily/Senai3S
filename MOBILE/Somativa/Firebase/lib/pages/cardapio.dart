import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import './produto_form.dart'; // tela de adicionar/editar produto

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("../assets/images/bgCardapio.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Lista de produtos do Firestore
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("produtos").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.only(top: 150),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final produto = docs[index];
                  final dados = produto.data() as Map<String, dynamic>;

                  return Center(
                    child: Container(
                      width: 250,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          // imagem opcional
                          if (dados["imagem"] != null)
                            Image.asset(
                              dados["imagem"],
                              width: 150,
                            ),

                          const SizedBox(height: 10),
                          Text(
                            dados["nome"] ?? "Sem nome",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("R\$ ${dados["preco"]}"),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProdutoForm(
                                        id: produto.id,
                                        dados: dados,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Editar"),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("produtos")
                                      .doc(produto.id)
                                      .delete();
                                },
                                child: const Text("Excluir"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Botão Home
          Positioned(
            top: 40,
            left: 10,
            child: SizedBox(
              width: 150,
              height: 45,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AppSalgadinhos()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 168, 85, 16).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Botão de adicionar novo produto
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 168, 85, 16),
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProdutoForm()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
