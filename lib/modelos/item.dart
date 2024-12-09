import 'package:cloud_firestore/cloud_firestore.dart';
import '../controladores/livroControlador.dart';
import 'livro.dart';

class Item {
  Livro livro;
  int quantidade;

  Item({required this.livro, required this.quantidade});

  static Future<Item?> fromDocumento(
      DocumentSnapshot<Object?> documento) async {
    try {
      String idLivro = documento["idLivro"] ?? "";
      int quantidade = documento['quantidade'] ?? 0;

      // Chama o método assíncrono e aguarda o retorno
      Livro? livroDoItem = await LivroControlador().getLivro(idLivro);

      if (livroDoItem != null) {
        return Item(livro: livroDoItem, quantidade: quantidade);
      } else {
        print('Livro não encontrado para o item');
      }
    } catch (error) {
      print('Erro ao criar Item: $error');
    }

    return null;
  }
}
