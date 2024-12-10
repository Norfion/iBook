import 'package:cloud_firestore/cloud_firestore.dart';

class Livro {
  String id;
  String titulo;
  String nomeAutor;
  List<String> generos;
  int anoPublicacao;
  String sinopse;
  String urlCapa;
  double preco;

  Livro(
      {required this.id,
      required this.titulo,
      required this.nomeAutor,
      required this.generos,
      required this.anoPublicacao,
      required this.sinopse,
      required this.urlCapa,
      required this.preco});

  // Retorna um objeto Livro formado a partir de um documento no Fire Store
  factory Livro.fromDocumento(DocumentSnapshot<Object?> documento) {
    List<String> generos = [];
    if (documento['generos'] != null) {
      for (String genero in List<String>.from(documento['generos'])) {
        generos.add(genero);
      }
    }

    return Livro(
      id: documento.id,
      titulo: documento["titulo"] ?? "",
      nomeAutor: documento["autor"] ?? "",
      generos: generos,
      anoPublicacao: documento["ano"] ?? 0,
      sinopse: documento["sinopse"] ?? "",
      preco: documento["preco"] ?? 0.0,
      urlCapa: documento["capa"] ?? "",
    );
  }
}

extension LivroExtensions on Livro {
  // Converte o objeto Livro em um Map para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': nomeAutor,
      'generos': generos,
      'ano': anoPublicacao,
      'sinopse': sinopse,
      'capa': urlCapa,
      'preco': preco,
    };
  }

  // Método estático para salvar o Livro no Firestore
  static Future<void> adicionarLivro(Livro livro) async {
    try {
      await FirebaseFirestore.instance.collection('livros').add(livro.toMap());
      print('Livro adicionado com sucesso!');
    } catch (e) {
      print('Erro ao adicionar livro: $e');
    }
  }
}
