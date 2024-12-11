import 'package:cloud_firestore/cloud_firestore.dart';
import 'item.dart';
import '../controladores/itemControlador.dart';

class Pedido {
  String id;
  List<Item> itens;
  String uidUsuario;
  String situacao;

  Pedido(
      {required this.id,
      required this.itens,
      required this.uidUsuario,
      required this.situacao});

  double getValorTotal() {
    double total = 0.0;

    for (int i = 0; i < itens.length; i++) {
      total += itens[i].livro.preco * itens[i].quantidade;
    }

    return total;
  }

  int getQuantidade() {
    int quantidade = 0;

    for (int i = 0; i < itens.length; i++) {
      quantidade += itens[i].quantidade;
    }

    return quantidade;
  }

  static Future<Pedido?> fromDocumento(
      QueryDocumentSnapshot<Object?> documento) async {
    try {
      List<dynamic> idsDosItens = documento['idItens'] ?? [];
      List<Item> itens = [];

      for (String idItem in idsDosItens.cast<String>()) {
        Item? item = await ItemControlador().getItem(idItem);
        if (item != null) {
          itens.add(item);
        }
      }

      return Pedido(
          id: documento.id,
          itens: itens,
          uidUsuario: documento['uidUsuario'] ?? '',
          situacao: documento['situacao'] ?? '');
    } catch (error) {
      print('Erro ao criar pedido: $error');
      return null;
    }
  }
}
