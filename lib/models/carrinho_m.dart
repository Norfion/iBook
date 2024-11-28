import 'package:projeto_p1/models/item.dart';

import 'livro_m.dart';

class Carrinho {
  List<Item> itens;

  Carrinho(this.itens);

  addLivro(Livro livro) {
    // Verifica se o livro já está no carrinho
    bool livroExistente = false;
    late int indiceItem;

    for (int i = 0; i < itens.length; i++) {
      if (itens[i].livro.id == livro.id) {
        livroExistente = true;
        indiceItem = i;
        break;
      }
    }

    if (livroExistente) {
      // Se o livro já estiver no carrinho, apenas incrementa a quantidade
      itens[indiceItem].quantidade += 1;
    } else {
      // Caso contrário, adiciona o item ao carrinho com a quantidade inicial de 1
      Item novoItem = Item(livro, 1);
      itens.add(novoItem);
    }
  }

  removerLivro(Livro livro) {
    // Verifica se o livro já está no carrinho
    bool livroExistente = false;
    late int indiceItem;

    for (int i = 0; i < itens.length; i++) {
      if (itens[i].livro.id == livro.id) {
        livroExistente = true;
        indiceItem = i;
        break;
      }
    }

    if (livroExistente) {
      // Se o livro já estiver no carrinho, apenas incrementa a quantidade
      itens[indiceItem].quantidade -= 1;
    } else {
      // Caso contrário, remove o item do carrinho
      itens.removeAt(indiceItem);
    }
  }


  double getValorTotal() {
    double total = 0.0;

    for (int i = 0; i < itens.length; i++) {
      total += itens[i].getSubTotal();
    }
    return total;
  }

  int getQtdItens() {
    return itens.length;
  }

  int getQtdLivros(){
    int qtdLivros = 0;

    for(int i = 0; i < itens.length; i++){
      qtdLivros += itens[i].getQuantidade();
    }

    return qtdLivros;
  }
}
