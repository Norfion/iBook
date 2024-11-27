import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/livro_m.dart';

class LivroController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Livro>> getLivros() async {
    List<Livro> lista = [];
    try {
      await db.collection('livros').get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          lista.add(Livro.fromDoc(doc));
        }
      });
    } catch (error) {
      print('Erro: $error');
    }

    return lista;
  }
}
