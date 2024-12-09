import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/livro.dart';

class LivroControlador {
  // Inicializa uma conexão com o Fire Store
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Livro?> getLivro(String idLivro) async {
    try {
      DocumentSnapshot<Object?> documento =
          await firestore.collection('livros').doc(idLivro).get();

      if (documento.exists) {
        return Livro.fromDocumento(documento);
      } else {
        print('Livro não encontrado');
      }
    } catch (error) {
      print('Erro: $error');
    }
    return null;
  }

  // Retorna todos livros do banco de dados através de um array de objetos Livro
  Future<List<Livro>> getLivros() async {
    List<Livro> listaLivros = [];

    try {
      await firestore.collection('livros').get().then((QuerySnapshot consulta) {
        for (var documento in consulta.docs) {
          listaLivros.add(Livro.fromDocumento(documento));
        }
      });
    } catch (error) {
      print('Erro: $error');
    }

    return listaLivros;
  }
}
