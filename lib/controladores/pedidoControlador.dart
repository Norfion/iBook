// ignore_for_file: avoid_print

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

        return Pedido(
            id: documento.id,
            itens: itensPedido,
            uidUsuario: documento['uidUsuario'] ?? '');
      } else {
        // Pedido não encontrado, criar um novo
        await firestore.collection('pedidos').add({
          'uidUsuario': uidUsuario.toString(),
          'idItens': [] // Pedido inicia vazio
        });

        // Chama recursivamente para buscar o pedido criado
        return await getPedido(uidUsuario);
      }
    } catch (error) {
      print('Erro ao recuperar ou criar pedido: $error');
      rethrow; // Propaga o erro
    }
  }

  Future<void> addLivroPedido(String idLivro, Pedido pedido) async {
    try {
      List<Item> itensPedido = pedido.itens;

      // Passo 4: Inicializa a variável para verificar se o livro já está no pedido
      bool existeLivro = false;
      String? idItemLivro;

      // Passa pelos itens para verificar se o livro já está no pedido
      for (var item in itensPedido) {
        if (item.livro.id == idLivro) {
          existeLivro = true;
          idItemLivro = item.id;
          break;
        }
      }

      // Se o livro já existe em um item
      if (existeLivro && idItemLivro != null) {
        try {
          // Passo 5.1.1: Livro já está no pedido
          Item? item = await ItemControlador().getItem(idItemLivro);

          int quantidadeNova = item!.quantidade + 1;
          // Referência ao documento na coleção "itens" pelo idItem
          DocumentReference documento =
              FirebaseFirestore.instance.collection('itens').doc(idItemLivro);

          // Atualiza o campo "quantidade" com o valor de novaQuantidade
          await documento.update({'quantidade': quantidadeNova});
          print("Quantidade atualizada com sucesso para o item $idItemLivro.");
        } catch (error) {
          // Tratamento de erros
          print("Erro ao atualizar a quantidade do item $idItemLivro: $error");
        }
      } else {
        // Passo 6.1: Livro não está no pedido, criar novo item
        DocumentReference novodocumento = firestore.collection('itens').doc();

        await novodocumento.set({
          'idLivro': idLivro,
          'quantidade': 1,
        });

        String novoIdItem = novodocumento.id;

        // Passo 6.1.2: Adicionar o novo ID na coleção 'pedidos'
        QuerySnapshot pedidoSnapshot = await firestore
            .collection('pedidos')
            .where('uidUsuario', isEqualTo: pedido.uidUsuario)
            .limit(1)
            .get();

        if (pedidoSnapshot.docs.isNotEmpty) {
          DocumentReference documento = pedidoSnapshot.docs.first.reference;

          await documento.update({
            'idItens': FieldValue.arrayUnion([novoIdItem])
          });
        } else {
          throw Exception("Pedido não encontrado para o usuário.");
        }
      }
    } catch (error) {
      print("Erro ao adicionar livro ao pedido: $error");
    }
  }

  Future<void> removerLivroPedido(String idLivro, Pedido pedido) async {
    try {
      List<Item> itensPedido = pedido.itens;
      Item? itemComLivro;

      // Passo 4: Inicializa a variável para verificar se o livro já está no pedido
      bool existeLivro = false;
      String? idItemLivro;

      // Passa pelos itens para verificar se o livro já está no pedido
      for (var item in itensPedido) {
        if (item.livro.id == idLivro) {
          existeLivro = true;
          idItemLivro = item.id;
          itemComLivro = item;
          break;
        }
      }

      // Se não existe livro em nenhum item do pedido, encerra, pois não há o que remover
      if (!existeLivro) {
        return;
      } else if (itemComLivro!.quantidade == 1) {
        try {
          // Referência ao documento na coleção "itens"
          DocumentReference documento =
              FirebaseFirestore.instance.collection('itens').doc(idItemLivro);

          // Remove o documento
          await documento.delete();

          print("Item com ID $idItemLivro removido com sucesso.");
        } catch (error) {
          print("Erro ao remover o item com ID $idItemLivro: $error");
        }
      } else {
        try {
          Item? item = await ItemControlador().getItem(idItemLivro!);

          int quantidadeNova = item!.quantidade - 1;

          // Referência ao documento na coleção "itens" pelo idItem
          DocumentReference documento =
              FirebaseFirestore.instance.collection('itens').doc(idItemLivro);

          // Atualiza o campo "quantidade" com o valor de novaQuantidade
          await documento.update({'quantidade': quantidadeNova});
        } catch (erro) {
          print('Erro ao diminuir a quantidade do item: $erro');
        }
      }
    } catch (error) {
      print("Erro ao remover ou diminuir a quantidade do pedido: $error");
    }
  }

  Future<void> apagarPedido(Pedido pedido) async {
    try {
      // Referência ao documento na coleção "pedidos"
      DocumentReference documento =
          FirebaseFirestore.instance.collection('pedidos').doc(pedido.id);

      // Remove o documento
      await documento.delete();

      print("Pedido do usuário com ID ${pedido.id} removido com sucesso.");
    } catch (error) {
      print("Erro ao apagar o pedido do usuário: $error");
    }
  }
}
