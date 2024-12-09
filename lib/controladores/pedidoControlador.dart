import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_p1/controladores/itemControlador.dart';

import '../modelos/item.dart';
import '../modelos/pedido.dart';

class PedidoControlador {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Recupera o pedido associado ao UID do usuário.
  /// Cria um novo pedido se não existir e depois retorna.
  Future<Pedido> getPedido(String uidUsuario) async {
    List<Item> itensPedido = [];
    try {
      // Consulta para buscar o pedido do usuário
      QuerySnapshot consulta = await firestore
          .collection('pedidos')
          .where('uidUsuario', isEqualTo: uidUsuario)
          .limit(1)
          .get();

      if (consulta.docs.isNotEmpty) {
        // Pedido encontrado
        DocumentSnapshot documento = consulta.docs.first;

        for (String idItem in List<String>.from(documento['idItens'])) {
          Item? item = await ItemControlador().getItem(idItem);
          if (item != null) {
            itensPedido.add(item);
          }
        }

        return Pedido(itens: itensPedido);
      } else {
        // Pedido não encontrado, criar um novo
        await firestore.collection('pedidos').add({
          'uidUsuario': uidUsuario.toString(), // Pedido inicia vazio
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
