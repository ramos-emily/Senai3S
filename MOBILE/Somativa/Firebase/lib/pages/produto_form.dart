import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/widgets/input_padrao.dart';


class ProdutoForm extends StatefulWidget {
  final String? id;
  final Map<String, dynamic>? dados;

  const ProdutoForm({super.key, this.id, this.dados});

  @override
  State<ProdutoForm> createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController preco = TextEditingController();
  final TextEditingController imagem = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.dados != null) {
      nome.text = widget.dados!["nome"];
      preco.text = widget.dados!["preco"].toString();
      imagem.text = widget.dados!["imagem"] ?? "";
    }
  }

  Future<void> salvar() async {
    final dados = {
      "nome": nome.text,
      "preco": double.tryParse(preco.text) ?? 0,
      "imagem": imagem.text
    };

    if (widget.id == null) {
      await FirebaseFirestore.instance.collection("produtos").add(dados);
    } else {
      await FirebaseFirestore.instance.collection("produtos").doc(widget.id).update(dados);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Novo Produto" : "Editar Produto"),
        backgroundColor: Colors.black.withOpacity(0.7),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../assets/images/bgCardapio.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              inputPadrao(controller: nome, label: "Nome"),
              const SizedBox(height: 16),
              inputPadrao(controller: preco, label: "Preço"),
              const SizedBox(height: 16),
              inputPadrao(controller: imagem, label: "Imagem (asset opcional)"),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: salvar,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
