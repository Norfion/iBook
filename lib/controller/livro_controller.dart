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

  Future<String> buscarIdLivroPorId(String idLivro) async {
    try {
      // Referência à coleção 'livros'
      CollectionReference livrosRef =
          FirebaseFirestore.instance.collection('livros');

      // Consulta para verificar se existe um documento onde o campo 'id' é igual ao parâmetro passado
      QuerySnapshot querySnapshot =
          await livrosRef.where('id', isEqualTo: idLivro).get();

      // Verifica se algum documento foi encontrado
      if (querySnapshot.docs.isNotEmpty) {
        // Retorna o 'id' do primeiro documento encontrado
        return querySnapshot.docs.first.id;
      } else {
        // Caso não encontre, retorna uma string vazia ou algum valor padrão
        return '';
      }
    } catch (e) {
      print("Erro ao buscar livro: $e");
      return ''; // Retorna uma string vazia em caso de erro
    }
  }
}
