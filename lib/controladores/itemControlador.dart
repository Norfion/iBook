import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/item.dart';

class ItemControlador {
  // Inicializa uma conexão com o Fire Store
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Item?> getItem(String idItem) async {
    try {
      DocumentSnapshot<Object?> documento =
          await firestore.collection('itens').doc(idItem).get();

      if (documento.exists) {
        return await Item.fromDocumento(documento);
      } else {
        print('Item não encontrado');
      }
    } catch (error) {
      print('Erro: $error');
    }

    return null;
  }
}
