class Livro {
  String titulo;
  String nomeAutor;
  String genero;
  int anoPublicacao;
  String codISBN;
  String sinopse;
  double? preco;
  double? qtdEstrelas;
  String _urlCapa;

  Livro(this.titulo, this.nomeAutor, this.genero, this.anoPublicacao, this.codISBN,
      this.sinopse, this.preco, this.qtdEstrelas, this._urlCapa);

  String getUrlCapa() {
    return this._urlCapa;
  }

  getTitulo() {
    return this.titulo;
  }

  getNomeAutor() {
    return this.nomeAutor;
  }

  getGenero(){
    return this.genero;
  }
}
