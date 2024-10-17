class Livro {
  String titulo;
  String nomeAutor;
  List<String> generos;
  int anoPublicacao;
  String codISBN;
  String sinopse;
  double? preco;
  double? qtdEstrelas;
  String _urlCapa;
  int quantidade = 0;

  Livro(this.titulo, this.nomeAutor, this.generos, this.anoPublicacao,
      this.codISBN, this.sinopse, this.preco, this.qtdEstrelas, this._urlCapa);


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
}
