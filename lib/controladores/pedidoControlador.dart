import 'package:cloud_firestore/cloud_firestore.dart';

import '../modelos/item.dart';
import '../modelos/pedido.dart';

class PedidoControlador {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Recupera o pedido associado ao UID do usuário.
  /// Cria um novo pedido se não existir e depois retorna.
  Future<Pedido> getPedido(String uidUsuario) async {
    try {
      // Consulta para buscar o pedido do usuário
      QuerySnapshot pedidoSnapshot = await firestore
          .collection('pedidos')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .limit(1)
          .get();

      if (pedidoSnapshot.docs.isNotEmpty) {
        // Pedido encontrado
        DocumentSnapshot pedidoDoc = pedidoSnapshot.docs.first;

        // Obtém os IDs dos itens associados ao pedido
        List<String> itensIds = List<String>.from(pedidoDoc['itens'] ?? []);

        // Carrega os itens do pedido a partir de seus IDs
        List<Item> itensDoPedido = [];
        for (String itemId in itensIds) {
          DocumentSnapshot itemDoc =
              await firestore.collection('itens').doc(itemId).get();

          if (itemDoc.exists) {
            itensDoPedido.add(Item.fromDocumento(itemDoc) as Item);
          }
        }

        return Pedido(itens: itensDoPedido);
      } else {
        // Pedido não encontrado, criar um novo
        await firestore.collection('pedidos').add({
          'uidUsuario': uidUsuario,
          'itens': [], // Pedido inicia vazio
        });

        // Chama recursivamente para buscar o pedido criado
        return await getPedido(uidUsuario);
      }
    } catch (error) {
      print('Erro ao recuperar ou criar pedido: $error');
      rethrow; // Propaga o erro
    }
  }
}
