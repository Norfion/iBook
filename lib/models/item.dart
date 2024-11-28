import 'package:projeto_p1/models/livro_m.dart';

class Item {
  Livro livro;
  int quantidade;

  Item(this.livro, this.quantidade);

  double getSubTotal() {
    double subTotal = 0.0;

    subTotal = livro.getPreco() * quantidade;

    return subTotal;
  }

  int getQuantidade(){
    return quantidade;
  }
}
