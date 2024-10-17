import 'package:projeto_p1/main.dart';

import 'livro_m.dart';

class Carrinho {
  List<Livro> livrosAdicionados;
  double valorTotal = 0.0;

  Carrinho(this.livrosAdicionados);

  addLivro(Livro livro) {
    // Verifica se o livro já está no carrinho
    bool livroExistente = false;
    int indiceDoLivro = 0;

    for (int i = 0; i < livrosAdicionados.length; i++) {
      if (livrosAdicionados[i].titulo == livro.titulo) {
        livroExistente = true;
        indiceDoLivro = i;
        break;
      }
    }

    if (livroExistente) {
      // Se o livro já estiver no carrinho, apenas incrementa a quantidade
      livrosAdicionados[indiceDoLivro].quantidade += 1;
    } else {
      // Caso contrário, adiciona o livro ao carrinho com a quantidade inicial de 1
      this.livrosAdicionados.add(livro);
      livrosAdicionados[livrosAdicionados.length - 1].quantidade = 1;
    }
  }

  getValorTotal() {
    double total = 0.0;

    for (int i = 0; i < livrosAdicionados.length; i++) {
      total += livrosAdicionados[i].preco ?? 0.0;
    }

    this.valorTotal = total;

    return valorTotal;
  }

  getQtdLivros() {
    int quantidade = 0;

    for (int i = 0; i < livrosAdicionados.length; i++) {
      quantidade += livrosAdicionados[i].quantidade;
    }

    return quantidade;
  }
}
