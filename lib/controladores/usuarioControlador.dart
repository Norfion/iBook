import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/usuario.dart';

class UsuarioControlador {
  // Inicializa uma conexão com o Fire Store
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Usuario?> getUsuario(String uidUsuario) async {
    try {
      // Busca diretamente o documento pelo UID assumindo que o UID é único
      QuerySnapshot querySnapshot = await firestore
          .collection('usuarios')
          .where('uid', isEqualTo: uidUsuario)
          .limit(1)
          .get(); // Retorna uma coleção de documentos

      if (querySnapshot.docs.isNotEmpty) {
        // Obtém o primeiro documento da consulta
        DocumentSnapshot documento = querySnapshot.docs.first;
        return Usuario.fromDocumento(documento);
      } else {
        print('Usuário não encontrado');
      }
    } catch (error) {
      print('Erro ao buscar usuário: $error');
    }
    return null;
  }

  static Future<String> getNomeUsuarioUID(String uidUsuario) async {
    try {
      // Referência à coleção 'usuarios'
      final CollectionReference usuarios =
          FirebaseFirestore.instance.collection('usuarios');

      // Query para encontrar o documento com o campo 'uid' igual ao parâmetro
      QuerySnapshot querySnapshot =
          await usuarios.where('uid', isEqualTo: uidUsuario).get();

      // Verifica se encontrou algum documento
      if (querySnapshot.docs.isNotEmpty) {
        // Pega o primeiro documento encontrado
        Map<String, dynamic> dados =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Retorna o valor do campo 'nome'
        return dados['nome'] ?? 'Nome não encontrado';
      } else {
        return '';
      }
    } catch (e) {
      // Trata erros e retorna uma mensagem
      print('Erro ao buscar nome do usuário: $e');
      return 'Erro ao buscar nome do usuário';
    }
  }
}
