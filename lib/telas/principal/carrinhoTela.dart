// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:projeto_p1/controladores/pedidoControlador.dart';
import 'package:projeto_p1/main.dart';
import '../../modelos/pedido.dart';
import '../principalTela.dart';

class Carrinhotela extends StatefulWidget {
  // Callback para atualizar a quantidade

  const Carrinhotela({super.key});

  @override
  _CarrinhotelaState createState() => _CarrinhotelaState();
}

class _CarrinhotelaState extends State<Carrinhotela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corSecundaria,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Resumo de compras',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: corPrimaria,
            fontFamily: fonte,
          ),
        ),
        backgroundColor: corSecundaria,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: pedido!.getQuantidade() == 0
            // Caso o carrinho esteja vazio
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ops! Seu carrinho está vazio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: corPrimaria,
                        fontFamily: fonte,
                      ),
                    ),
                    Text(
                      'Adicione livros ao seu carrinho para que apareçam aqui!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: corPrimaria,
                      ),
                    ),
                  ],
                ),
              )
            // Caso o carrinho não esteja vazio
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: pedido!.itens.length,
                      itemBuilder: (context, index) {
                        final livro = pedido!.itens[index].livro;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      livro.urlCapa,
                                      width: 80,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          livro.titulo,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: corTerciaria,
                                          ),
                                        ),
                                        Text(
                                          livro.nomeAutor,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: corPrimaria,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'R\$ ${livro.preco.toStringAsFixed(2)} / un',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: corPrimaria,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon:
                                        Icon(Icons.remove, color: corPrimaria),
                                    onPressed: () async {
                                      try {
                                        // Evita bug de multiplos cliques
                                        if (pedido!.itens[index].quantidade !=
                                            0) {
                                          // Remove o livro do pedido no Firestore
                                          await PedidoControlador()
                                              .removerLivroPedido(
                                                  pedido!.itens[index].livro.id,
                                                  pedido!);
                                        }

                                        // Recarrega o pedido atualizado
                                        Pedido pedidoAtualizado =
                                            await PedidoControlador()
                                                .getPedido(pedido!.uidUsuario);

                                        // Atualiza o estado do carrinho
                                        setState(() {
                                          pedido = pedidoAtualizado;
                                          qtdLivros = pedido!.getQuantidade();
                                        });
                                      } catch (error) {
                                        print(
                                            "Erro ao remover o livro do pedido: $error");
                                      }
                                    },
                                  ),
                                  Text(
                                    '${pedido!.itens[index].quantidade}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: corPrimaria,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: corPrimaria),
                                    onPressed: () async {
                                      try {
                                        // Chama o método para adicionar o livro ao pedido
                                        await PedidoControlador()
                                            .addLivroPedido(
                                                pedido!.itens[index].livro.id,
                                                pedido!);

                                        // Recarrega o pedido atualizado do Firestore
                                        Pedido pedidoAtualizado =
                                            await PedidoControlador()
                                                .getPedido(pedido!.uidUsuario);

                                        // Atualiza o estado local com os novos dados
                                        setState(() {
                                          pedido = pedidoAtualizado;
                                          qtdLivros = pedido!.getQuantidade();
                                        });

                                        print(
                                            "Livro adicionado ao carrinho com sucesso.");
                                      } catch (error) {
                                        print(
                                            "Erro ao adicionar o livro ao carrinho: $error");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: corPrimaria,
                          ),
                        ),
                        Text(
                          'R\$ ${pedido!.getValorTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: corTerciaria,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // Apaga o pedido no FireStore
                        await PedidoControlador().apagarPedido(pedido!);
                        // Atualiza o pedido com os dados mais recentes do Firestore
                        pedido = await PedidoControlador()
                            .getPedido(pedido!.uidUsuario);

                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Pedido finalizado'),
                              content: const Text(
                                  'Sua compra foi finalizada com sucesso! Agradecemos a preferência\n\nEm breve lhe enviaremos um e-mail com os detalhes do seu pedido'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      label: const Text('Finalizar compra'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corPrimaria,
                        foregroundColor: corSecundaria,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32.0,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
      ),
    );
  }
}
