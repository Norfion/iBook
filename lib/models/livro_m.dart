import 'package:cloud_firestore/cloud_firestore.dart';

class Livro {
  String id;
  String titulo;
  String nomeAutor;
  List<String> generos;
  int anoPublicacao;
  String sinopse;
  double? preco;
  String _urlCapa;

  Livro(this.id, this.titulo, this.nomeAutor, this.generos, this.anoPublicacao,
      this.sinopse, this.preco, this._urlCapa);

  String getUrlCapa() {
    return this._urlCapa;
  }

  getTitulo() {
    return this.titulo;
  }

  getNomeAutor() {
    return this.nomeAutor;
  }

  getListGeneros() {
    return this.generos;
  }

  getPreco() {
    return this.preco;
  }

  addGenero(String genero) {
    bool generoRepetido = false;
    for (int i = 0; i < this.generos.length; i++) {
      if (this.generos[i] == genero) {
        generoRepetido = true;
        break;
      }
    }

    if (!generoRepetido) {
      this.generos.add(genero);
    }
  }

  factory Livro.fromDoc(QueryDocumentSnapshot<Object?> doc) {
  

    List<String> generos = [];
    for (String g in doc['generos']) {
      generos.add(g);
    }

    return Livro(
      doc.id,
      doc["titulo"] ?? "",
      doc["autor"] ?? "",
      generos,
      doc["ano"] ?? 0,
      doc["sinopse"] ?? "",
      doc["preco"] ?? 0,
      doc["capa"] ?? "",
    );
  }
}
